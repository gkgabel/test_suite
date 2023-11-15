#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/elfnote-lto.h>
#include <linux/export-internal.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;
BUILD_LTO_INFO;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif


static const struct modversion_info ____versions[]
__used __section("__versions") = {
	{ 0xbdfb6dbb, "__fentry__" },
	{ 0xe011e171, "first_online_pgdat" },
	{ 0xa94a09bb, "mem_section" },
	{ 0xbcb36fe4, "hugetlb_optimize_vmemmap_key" },
	{ 0x97651e6c, "vmemmap_base" },
	{ 0x83eef890, "next_zone" },
	{ 0x15a70d5, "page_mapping" },
	{ 0xdf9671c1, "__page_mapcount" },
	{ 0x92997ed8, "_printk" },
	{ 0xf9a482f9, "msleep" },
	{ 0x5b8239ca, "__x86_return_thunk" },
	{ 0x6f9ee250, "module_layout" },
};

MODULE_INFO(depends, "");


MODULE_INFO(srcversion, "E66CC0A27F3495DFE0D7A1D");
