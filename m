From: Andrew Walrond <andrew@walrond.org>
Date: Wed, 08 Aug 2007 09:02:15 +0000
Subject: 2.6.22.1 kernel grinds...to......a............halt......
Message-Id: <46B98697.8090802@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Having got over the gcc 4.2 issue, I booted a seemingly good 2.6.22.1
kernel compiled with gcc 4.1.2.

However, after starting a big (whole distro) compilation job (several
make -j12 jobs in parallel), the machine begins to really slow down,
eventually becoming unresponsive. I notice build jobs beginning to fail
and my ssh connection is dropped.

I managed to login directly from the ALOM console, and typed dmesg.
Eventually, after a _long_ wait, I got the output below.

This is a 2Gb machine with 2Gb of swap running a distro (<1Gb) out of
initramfs. It has plenty of free ram at the start of the build (~1Gb)
so it really shouldn't be invoking the oom-killer I suspect.

Any clues as to what is going on? I can supply my .config if that will help.

Andrew Walrond

Free swap  = 1929224kB
Total swap = 1943848kB
Free swap:       1929224kB
262120 pages of RAM
4584 reserved pages
308 pages shared
188 pages swap cached
0 pages dirty
0 pages writeback
130 pages mapped
31744 pages slab
84 pages pagetables
printk: 495 messages suppressed.
bash invoked oom-killer: gfp_mask=0xd0, order=1, oomkilladj=0
Call Trace:
 [0000000000495af8] __get_free_pages+0x20/0xc0
 [0000000000460578] copy_process+0x80/0xfe0
 [0000000000461524] do_fork+0x4c/0x200
 [0000000000406214] linux_sparc_syscall+0x3c/0x44
 [0000000000006cf7] 0x6cff
Mem-info:
Normal per-cpu:
CPU    0: Hot: hi:   90, btch:  15 usd:  13   Cold: hi:   30, btch:   7
usd:  26
CPU    1: Hot: hi:   90, btch:  15 usd:   7   Cold: hi:   30, btch:   7
usd:  26
CPU    2: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  28
CPU    3: Hot: hi:   90, btch:  15 usd:  12   Cold: hi:   30, btch:   7
usd:  28
CPU    4: Hot: hi:   90, btch:  15 usd:  78   Cold: hi:   30, btch:   7
usd:  27
CPU    5: Hot: hi:   90, btch:  15 usd:  61   Cold: hi:   30, btch:   7
usd:  21
CPU    6: Hot: hi:   90, btch:  15 usd:  34   Cold: hi:   30, btch:   7
usd:  23
CPU    7: Hot: hi:   90, btch:  15 usd:  14   Cold: hi:   30, btch:   7
usd:  17
CPU    8: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  24
CPU    9: Hot: hi:   90, btch:  15 usd:  62   Cold: hi:   30, btch:   7
usd:   5
CPU   10: Hot: hi:   90, btch:  15 usd:  76   Cold: hi:   30, btch:   7
usd:  17
CPU   11: Hot: hi:   90, btch:  15 usd:  16   Cold: hi:   30, btch:   7
usd:   3
CPU   12: Hot: hi:   90, btch:  15 usd:  88   Cold: hi:   30, btch:   7
usd:  27
CPU   13: Hot: hi:   90, btch:  15 usd:   6   Cold: hi:   30, btch:   7
usd:  29
CPU   14: Hot: hi:   90, btch:  15 usd:  12   Cold: hi:   30, btch:   7
usd:  27
CPU   15: Hot: hi:   90, btch:  15 usd:  25   Cold: hi:   30, btch:   7
usd:  23
CPU   16: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  13
CPU   17: Hot: hi:   90, btch:  15 usd:   5   Cold: hi:   30, btch:   7
usd:   6
CPU   18: Hot: hi:   90, btch:  15 usd:  29   Cold: hi:   30, btch:   7
usd:   1
CPU   19: Hot: hi:   90, btch:  15 usd:  30   Cold: hi:   30, btch:   7
usd:  19
CPU   20: Hot: hi:   90, btch:  15 usd:  48   Cold: hi:   30, btch:   7
usd:  29
CPU   21: Hot: hi:   90, btch:  15 usd:  79   Cold: hi:   30, btch:   7
usd:   2
CPU   22: Hot: hi:   90, btch:  15 usd:  11   Cold: hi:   30, btch:   7
usd:  24
CPU   23: Hot: hi:   90, btch:  15 usd:   5   Cold: hi:   30, btch:   7
usd:   3
Active:110962 inactive:73433 dirty:0 writeback:0 unstable:0
 free:3254 slab:31744 mapped:130 pagetables:84 bounce:0
Normal free:26032kB min:5744kB low:7176kB high:8616kB active:887696kB
inactive:587464kB present:2065840kB pages_scanned:1455763
all_unreclaimable? yes
lowmem_reserve[]: 0
Normal: 2966*8kB 2*16kB 1*32kB 1*64kB 1*128kB 8*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB 0*8192kB = 26032kB
Swap cache: add 1143386, delete 1143203, find 197044/310169, race 2+17
Free swap  = 1929224kB
Total swap = 1943848kB
Free swap:       1929224kB
262120 pages of RAM
4584 reserved pages
308 pages shared
188 pages swap cached
0 pages dirty
0 pages writeback
130 pages mapped
31744 pages slab
84 pages pagetables
printk: 495 messages suppressed.
bash invoked oom-killer: gfp_mask=0xd0, order=1, oomkilladj=0
Call Trace:
 [0000000000495af8] __get_free_pages+0x20/0xc0
 [0000000000460578] copy_process+0x80/0xfe0
 [0000000000461524] do_fork+0x4c/0x200
 [0000000000406214] linux_sparc_syscall+0x3c/0x44
 [0000000000006cf7] 0x6cff
Mem-info:
Normal per-cpu:
CPU    0: Hot: hi:   90, btch:  15 usd:  11   Cold: hi:   30, btch:   7
usd:  26
CPU    1: Hot: hi:   90, btch:  15 usd:   7   Cold: hi:   30, btch:   7
usd:  26
CPU    2: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  28
CPU    3: Hot: hi:   90, btch:  15 usd:  12   Cold: hi:   30, btch:   7
usd:  28
CPU    4: Hot: hi:   90, btch:  15 usd:  78   Cold: hi:   30, btch:   7
usd:  27
CPU    5: Hot: hi:   90, btch:  15 usd:  61   Cold: hi:   30, btch:   7
usd:  21
CPU    6: Hot: hi:   90, btch:  15 usd:  34   Cold: hi:   30, btch:   7
usd:  23
CPU    7: Hot: hi:   90, btch:  15 usd:  14   Cold: hi:   30, btch:   7
usd:  17
CPU    8: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  24
CPU    9: Hot: hi:   90, btch:  15 usd:  62   Cold: hi:   30, btch:   7
usd:   5
CPU   10: Hot: hi:   90, btch:  15 usd:  76   Cold: hi:   30, btch:   7
usd:  17
CPU   11: Hot: hi:   90, btch:  15 usd:  16   Cold: hi:   30, btch:   7
usd:   3
CPU   12: Hot: hi:   90, btch:  15 usd:  88   Cold: hi:   30, btch:   7
usd:  27
CPU   13: Hot: hi:   90, btch:  15 usd:   6   Cold: hi:   30, btch:   7
usd:  29
CPU   14: Hot: hi:   90, btch:  15 usd:  12   Cold: hi:   30, btch:   7
usd:  27
CPU   15: Hot: hi:   90, btch:  15 usd:  25   Cold: hi:   30, btch:   7
usd:  23
CPU   16: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  13
CPU   17: Hot: hi:   90, btch:  15 usd:   5   Cold: hi:   30, btch:   7
usd:   6
CPU   18: Hot: hi:   90, btch:  15 usd:  29   Cold: hi:   30, btch:   7
usd:   1
CPU   19: Hot: hi:   90, btch:  15 usd:  30   Cold: hi:   30, btch:   7
usd:  19
CPU   20: Hot: hi:   90, btch:  15 usd:  48   Cold: hi:   30, btch:   7
usd:  29
CPU   21: Hot: hi:   90, btch:  15 usd:  79   Cold: hi:   30, btch:   7
usd:   2
CPU   22: Hot: hi:   90, btch:  15 usd:  11   Cold: hi:   30, btch:   7
usd:  24
CPU   23: Hot: hi:   90, btch:  15 usd:   5   Cold: hi:   30, btch:   7
usd:   3
Active:114956 inactive:69403 dirty:0 writeback:0 unstable:0
 free:3254 slab:31744 mapped:130 pagetables:84 bounce:0
Normal free:26032kB min:5744kB low:7176kB high:8616kB active:919648kB
inactive:555224kB present:2065840kB pages_scanned:1515379
all_unreclaimable? yes
lowmem_reserve[]: 0
Normal: 2966*8kB 2*16kB 1*32kB 1*64kB 1*128kB 8*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB 0*8192kB = 26032kB
Swap cache: add 1143386, delete 1143203, find 197044/310169, race 2+17
Free swap  = 1929224kB
Total swap = 1943848kB
Free swap:       1929224kB
262120 pages of RAM
4584 reserved pages
308 pages shared
188 pages swap cached
0 pages dirty
0 pages writeback
130 pages mapped
31744 pages slab
84 pages pagetables
printk: 495 messages suppressed.
bash invoked oom-killer: gfp_mask=0xd0, order=1, oomkilladj=0
Call Trace:
 [0000000000495af8] __get_free_pages+0x20/0xc0
 [0000000000460578] copy_process+0x80/0xfe0
 [0000000000461524] do_fork+0x4c/0x200
 [0000000000406214] linux_sparc_syscall+0x3c/0x44
 [0000000000006cf7] 0x6cff
Mem-info:
Normal per-cpu:
CPU    0: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  26
CPU    1: Hot: hi:   90, btch:  15 usd:   7   Cold: hi:   30, btch:   7
usd:  26
CPU    2: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  28
CPU    3: Hot: hi:   90, btch:  15 usd:  12   Cold: hi:   30, btch:   7
usd:  28
CPU    4: Hot: hi:   90, btch:  15 usd:  78   Cold: hi:   30, btch:   7
usd:  27
CPU    5: Hot: hi:   90, btch:  15 usd:  61   Cold: hi:   30, btch:   7
usd:  21
CPU    6: Hot: hi:   90, btch:  15 usd:  34   Cold: hi:   30, btch:   7
usd:  23
CPU    7: Hot: hi:   90, btch:  15 usd:  14   Cold: hi:   30, btch:   7
usd:  17
CPU    8: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  24
CPU    9: Hot: hi:   90, btch:  15 usd:  62   Cold: hi:   30, btch:   7
usd:   5
CPU   10: Hot: hi:   90, btch:  15 usd:  76   Cold: hi:   30, btch:   7
usd:  17
CPU   11: Hot: hi:   90, btch:  15 usd:  16   Cold: hi:   30, btch:   7
usd:   3
CPU   12: Hot: hi:   90, btch:  15 usd:  88   Cold: hi:   30, btch:   7
usd:  27
CPU   13: Hot: hi:   90, btch:  15 usd:   6   Cold: hi:   30, btch:   7
usd:  29
CPU   14: Hot: hi:   90, btch:  15 usd:  12   Cold: hi:   30, btch:   7
usd:  27
CPU   15: Hot: hi:   90, btch:  15 usd:  25   Cold: hi:   30, btch:   7
usd:  23
CPU   16: Hot: hi:   90, btch:  15 usd:  10   Cold: hi:   30, btch:   7
usd:  13
CPU   17: Hot: hi:   90, btch:  15 usd:   5   Cold: hi:   30, btch:   7
usd:   6
CPU   18: Hot: hi:   90, btch:  15 usd:  29   Cold: hi:   30, btch:   7
usd:   1
CPU   19: Hot: hi:   90, btch:  15 usd:  30   Cold: hi:   30, btch:   7
usd:  19
CPU   20: Hot: hi:   90, btch:  15 usd:  48   Cold: hi:   30, btch:   7
usd:  29
CPU   21: Hot: hi:   90, btch:  15 usd:  79   Cold: hi:   30, btch:   7
usd:   2
CPU   22: Hot: hi:   90, btch:  15 usd:  11   Cold: hi:   30, btch:   7
usd:  24
CPU   23: Hot: hi:   90, btch:  15 usd:   5   Cold: hi:   30, btch:   7
usd:   3
Active:118035 inactive:66401 dirty:0 writeback:0 unstable:0
 free:3254 slab:31744 mapped:130 pagetables:84 bounce:0
Normal free:26032kB min:5744kB low:7176kB high:8616kB active:944280kB
inactive:531208kB present:2065840kB pages_scanned:1575891
all_unreclaimable? yes
lowmem_reserve[]: 0
Normal: 2966*8kB 2*16kB 1*32kB 1*64kB 1*128kB 8*256kB 0*512kB 0*1024kB
0*2048kB 0*4096kB 0*8192kB = 26032kB
Swap cache: add 1143386, delete 1143203, find 197044/310169, race 2+17
Free swap  = 1929224kB
Total swap = 1943848kB
Free swap:       1929224kB
262120 pages of RAM
4584 reserved pages
308 pages shared
188 pages swap cached
0 pages dirty
0 pages writeback
130 pages mapped
31744 pages slab
84 pages pagetables
