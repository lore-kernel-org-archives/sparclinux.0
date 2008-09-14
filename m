From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 08:39:19 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809141136110.3619@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> So here is a debugging patch that will trace the execution of mem_init() so
> that we can perhaps figure out which part causes this crash.

It's after mem_init as below.

> Another thing you can do is type ".registers" when you get that firmware
> prompt after the crash.  It will spit out some cpu state.

Booting Linux...
CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
FHC(board 5): Version[1] PartID[fa0] Manuf[3e]
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 
161646
Kernel command line: root=/dev/sda2 ro debug
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
mem_init(): ENTER
mem_init(): memset() on sparc64_valid_addr_bitmap(fffff8000032d180)
mem_init(): setup_valid_addr_bitmap_from_pavail()
mem_init(): free_bootmem()
mem_init(): Allocate mem_map_zero()
Memory: 1276264k available (2856k kernel code, 1136k data, 168k init) 
[fffff80000000000,000000004fcfa000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Calibrating delay using timer specific routine.. 801.67 BogoMIPS 
(lpj@08382)
Mount-cache hash table entries: 512
Fast Data Access MMU Miss
{7} ok .registers
        Normal          Alternate       MMU               Vector
0:                 0                0                0                0
1:            781100                6         fff9f6d0 ffffffffffffffff
2:            798c00      1ccf8207c08         f0000000         f0000000
3:          fffd0000                1                1         fffd0000
4:          deadbeef      1ccf8207c10                1         f004c99c
5:          deadbeef                1                f               aa
6:          deadbeef           200000         fffd0000         fff9f000
7:                10                0               68                7
%PC  5813c0 %nPC 5813c4
%TBA f0000000 %CCR 44 XCC:nZvc   ICC:nZvc


-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
