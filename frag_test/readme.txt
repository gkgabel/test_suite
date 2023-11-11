Some observations that might help in future while changing parameter:
1. More jobs than 9000 will exhaust 32G mem
2. Even if we launch two batches of job instead of one which is originally here, the fragmentation will not be affected much
3. libaio is heavily loaded in CPU and less in RAM so thesemany cannot run in libaio mode. More needs to be looked at
4. This experiment is very sensitive to machine specs. On another machine with 4 physical and 8 logical core, the fragmentation was much higher (~68% compared to ~62% here). XXXXXXXXX This seems wrong because I can replicate the same experiment here. It is just the way how I am executing it. If doing manual execution, I can get much higher fragmentation, but doing by a shell script I cannot. May be a timing issue.
This why there is another script here whichreplicates the issue from previous machine.
5. One must be careful of setting the initial sleep duration in killer.sh script. It may differ based on machine.

Folder Name:
Case 1: Direct=0 # buffered I/O (~62%)
Case 2: Direct=1 # non bufferd I/O (~68%)
Case 3: Direct=1 # non buffered I/O + 5 batches (4 large batches one small batch that is paused) (~68%)
