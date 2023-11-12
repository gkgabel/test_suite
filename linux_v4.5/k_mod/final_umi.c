#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/kthread.h>
#include <linux/sched.h>
#include <linux/completion.h>
#include <linux/mm.h>
#include <linux/mm_types.h>
#include <linux/mmzone.h>
#include <linux/page_ext.h>
#include <linux/pagemap.h>
#include <linux/delay.h>
#include <linux/page-isolation.h>
int page_group_by_mobility_disabled = 0;

unsigned long unmov_pb_occupancy[5]={};
unsigned long total_pb_occupancy[5]={};

extern struct zone *next_zone(struct zone *zone);
// extern int get_pfnblock_migratetype(const struct page *page,unsigned long pfn);
static int page_order(struct page *page)
{
	return page_private(page);
}

unsigned long nr_mov_pb,nr_unmov_pb,unmov;
unsigned long nr_unmovable_pages;
unsigned long nr_movable_pages,pg_bud,pg_lru,pg_mov,pg_res,pg_map,pg_other;


static unsigned long count_wired_pages(unsigned long start_pfn, unsigned long end_pfn)
{
	unsigned long pfn;
	unsigned long local_unmov=0,local_mov=0;
	struct page *page;
	bool flag = false;

	for (pfn = start_pfn; pfn < end_pfn;pfn++) {
		if (!pfn_valid(pfn))
			continue;
		
		page = pfn_to_page(pfn);
		if(PageBuddy(page))
		{
			pg_bud += (1UL << page_order(page));
			pfn += (1UL << page_order(page))-1;
			nr_movable_pages+=(1UL << page_order(page));
			//local_mov+=(1UL << page_order(page));
			continue;
		}

        if(PageLRU(page)){
			pg_lru++;
            nr_movable_pages++;
            local_mov++;
            continue;
        }

		//if(__PageMovable(page)){
		//	pg_mov++;
           // nr_movable_pages++;
           //local_mov++;
            //continue;
        //}
		 /*
         * Both, bootmem allocations and memory holes are marked
         * PG_reserved and are unmovable. We can even have unmovable
         * allocations inside ZONE_MOVABLE, for example when
         * specifying "movablecore".
         */

		if(PageReserved(page)){
			//flag=true;
			pg_res++;
			nr_movable_pages++;
			//local_mov++;
			continue;
		}

		struct address_space *mapping = page_mapping(page);
        if (!mapping && page_count(page) > page_mapcount(page)){
			flag=true;
			pg_map++;
			local_unmov++;
			nr_unmovable_pages++;
			continue;
		}

		pg_other++;
		nr_movable_pages++;
		//local_mov++;
		continue;
		
    }
	if(flag)
	{
		nr_unmov_pb++;
		if(local_unmov<=pageblock_nr_pages>>2)unmov_pb_occupancy[0]++;
		else if(local_unmov<=pageblock_nr_pages>>1)unmov_pb_occupancy[1]++;
		else if(local_unmov<=3*pageblock_nr_pages>>2)unmov_pb_occupancy[2]++;
		else if(local_unmov<=pageblock_nr_pages)unmov_pb_occupancy[3]++;
		else 
		{
			printk("Overflow %lu",local_unmov);
			unmov_pb_occupancy[4]++;
		}
		
		if(local_mov+local_unmov<=pageblock_nr_pages>>2)total_pb_occupancy[0]++;
		else if(local_mov+local_unmov<=pageblock_nr_pages>>1)total_pb_occupancy[1]++;
		else if(local_mov+local_unmov<=3*pageblock_nr_pages>>2)total_pb_occupancy[2]++;
		else if(local_mov+local_unmov<=pageblock_nr_pages)total_pb_occupancy[3]++;
		else 
		{
			printk("Overflow %lu",local_mov+local_unmov);
			total_pb_occupancy[4]++;
		}
		
	}
	else if(pfn>end_pfn)
		nr_mov_pb+=2;
	else
		nr_mov_pb++;
	return pfn;
}


static void printk_composite_superpages(struct zone *zone)
{
	struct page *page;
	unsigned long pfn = zone->zone_start_pfn, block_end_pfn;
	unsigned long end_pfn = pfn + zone->spanned_pages;
	int pageblock_mt;
	/* Scan block by block. First and last block may be incomplete */
	pfn = zone->zone_start_pfn;

	/*
	 * Walk the zone in pageblock_nr_pages steps. If a page block spans
	 * a zone boundary, it will be double counted between zones. This does
	 * not matter as the mixed block count will still be correct
	 */
	for (; pfn < end_pfn; ) {
		if (!pfn_valid(pfn)) {
			pfn = ALIGN(pfn + 1, MAX_ORDER_NR_PAGES);
			continue;
		}

		block_end_pfn = ALIGN(pfn + 1, pageblock_nr_pages);
		block_end_pfn = min(block_end_pfn, end_pfn);
		page = pfn_to_page(pfn);
		if(has_unmovable_pages(zone,page,0,true))unmov++;
	    unsigned long num=count_wired_pages(pfn, block_end_pfn);
		pfn=num;
		continue;
			
	}
}

int init_module(void){
        struct zone *zone;
	while(1)
	{
		unmov = 0;
		unmov_pb_occupancy[0]=unmov_pb_occupancy[1]=unmov_pb_occupancy[2]=unmov_pb_occupancy[3]=unmov_pb_occupancy[4]=0;
		nr_movable_pages = nr_unmovable_pages = pg_bud =pg_lru = pg_mov =pg_res =pg_map = pg_other =nr_unmov_pb=nr_mov_pb =0;
        	for_each_zone(zone) {
                        printk_composite_superpages(zone);
        	}
		printk("Pages: Mov Unmov %lu %lu\n",nr_movable_pages,nr_unmovable_pages);
		printk("Pages: Bud Lru Mov Res Map Other %lu %lu %lu %lu %lu %lu\n",pg_bud,pg_lru,pg_mov,pg_res,pg_map,pg_other);
		printk("Total Memory:%lu\n",(nr_movable_pages+nr_unmovable_pages)/256);
		printk("Memory: Bud, Lru Mov Res Map Other %lu %lu %lu %lu %lu %lu\n",pg_bud/256,pg_lru/256,pg_mov/256,pg_res/256,pg_map/256,pg_other/256);
		printk("Pbs: Mov Unmov %lu %lu\n",nr_mov_pb,nr_unmov_pb);
		unsigned long umi = 100*nr_unmov_pb/(nr_mov_pb+nr_unmov_pb);
		printk("umi: %lu\n",umi);
		printk("Unmov Pb Occupancy: 25%% 50%% 75%% 100%% >100%% %lu %lu %lu %lu %lu \n",unmov_pb_occupancy[0]++,unmov_pb_occupancy[1]++,unmov_pb_occupancy[2]++,unmov_pb_occupancy[3]++,unmov_pb_occupancy[4]++);
		printk("Total Pb Occupancy: 25%% 50%% 75%% 100%% >100%% %lu %lu %lu %lu %lu \n",total_pb_occupancy[0]++,total_pb_occupancy[1]++,total_pb_occupancy[2]++,total_pb_occupancy[3]++,total_pb_occupancy[4]++);
	printk("Unmov_Pageblocks_using_has_unmovable_pages() =  %lu \n",unmov);
    	printk("Completed !!!\n");
		msleep(4800);

    }
	return 0;

}

void cleanup_module(void){
    printk("Unloading module.\n");
}

MODULE_LICENSE("GPL");
