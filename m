From: Bob Picco <bpicco@meloft.net>
Date: Fri, 26 Sep 2014 20:04:18 +0000
Subject: Re: [PATCH 0/6] sparc64: MM/IRQ patch queue.
Message-Id: <20140926200418.GK4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140925.154047.2222645314356554322.davem@davemloft.net>
In-Reply-To: <20140925.154047.2222645314356554322.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
Bob Picco wrote:	[Fri Sep 26 2014, 10:28:16AM EDT]
> David Miller wrote:	[Thu Sep 25 2014, 11:59:48PM EDT]
> > From: Bob Picco <bpicco@meloft.net>
> > Date: Thu, 25 Sep 2014 18:37:18 -0400
> > 
> > > You might want to tone these down:
> > > [10014000000-100147fffff] PMD -> [ffff801fda800000-ffff801fdaffffff] on node
> > > or terminate them altogether. Only a suggestion and will inspect further.
> > 
> > I used x86 as a model, but I guess with fragmented guest memory it can
> > be a bit overboard.
> Well I'm on a guest about as much as you. I did ask a question about the
> guest fragmented memory (MAX_BANKS) but haven't heard back. Though a guest
> really has little knowledge of the MCU.
> > 
> > It's KERN_DEBUG too btw, which means that unless you ask for it you
> > won't see those messages.  I bet on the real console they don't
> > appear, but if you look at dmesg you'll certainly see them.
> I agree. The real benefit is to people like you and I who don't want to
> walk the page table state for a struct page. Possibly also for those that
> don't have an equivalent to crash. This is made more of a challenge by our
> changes.
> > 
> > >> I'm eager to push this, but I also want it to get tested so I'll hold
> > >> off for about a day or so in order to give some time for that.
> > > DEBUG_PAGEALLOC wasn't healthy on T5-2. I'll scrutinize further in the
> > > morning. It could be a legitimate issue.
> > 
> > Strange, does it hang or OOPS?  Can you show me the OOPS messages if
> > you have them?
> Let me examine first. Yesterday I put my shorts on backwards and doubt certain
> cranial activity.
We aren't doing so swift or I made a mistake. M7 is flaky which has caused
me grief and probably requires, like Karl suggested, an AC recycle.
This seems(?) to point at vmemmap. I will pursue.

Plus rumor has it CPU upgrades are today. This may require FW upgrade too.
You know as much as me.

I've barely had time to examine DEBUG_PAGEALLOC on T5-2.

This should provide you sufficient data to arrive at an initial vmalloc size
for percpu. I'll eventually examine my T5-8 information too. Hm, just did
quickly:
PERCPU: max_distance=0x380001c10000 too large for vmalloc space 0xff00000000
. Note I haven't considered impact of this in quite a bit.

First I will examine the preprocessor output of several files and examine
boundary conditions.

thanx! My energy level is exponentially decaying.

boot: 3.17.0-rc4 
Allocated 64 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loading initial ramdisk (194296953 bytes at 0xC00004000000 phys, 0x40C00000 virt)
PROMLIB: Sun IEEE Boot Prom 'OBP 042914_5b6e3f9d8b48 2014/04/29 21:34'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.17.0-rc4 (root@ca-sparc30.us.oracle.com) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-4) (GCC) ) #2 SMP Fri Sep 26 13:34:44 ADT 2014
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:10:e0:56:96:4a
PAGE_OFFSET is 0xfffe000000000000 (max_phys_bits = 49)
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 1254513 bytes of memory.
MDESC: Size is 713520 bytes.
PLATFORM: banner-name [SPARC T7-4]
PLATFORM: name [sun4v-platform]
PLATFORM: hostid [8656964a]
PLATFORM: serial# [0056964a]
PLATFORM: stick-frequency [3b9aca00]
PLATFORM: mac-address [10e056964a]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [1024]
Allocated 49152 bytes for kernel page tables.
Zone ranges:
  DMA      [mem 0x50400000-0xffffffffffffffff]
  Normal   [mem 0x00000000-0xc03bffd8bfff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x50400000-0x3fbf0fbfff]
  node   0: [mem 0x3fbf102000-0x3fbf103fff]
  node   1: [mem 0x400000000000-0x4003ffffffff]
  node   1: [mem 0x404000000000-0x4043ffffffff]
  node   1: [mem 0x408000000000-0x4083ffffffff]
  node   1: [mem 0x40c000000000-0x40c3ffffffff]
  node   1: [mem 0x414000000000-0x4143ffffffff]
  node   1: [mem 0x41c000000000-0x41c3ffffffff]
  node   1: [mem 0x420000000000-0x4203ffffffff]
  node   1: [mem 0x424000000000-0x4243ffffffff]
  node   1: [mem 0x428000000000-0x4283ffffffff]
  node   1: [mem 0x42c000000000-0x42c3ffffffff]
  node   1: [mem 0x434000000000-0x4343ffffffff]
  node   1: [mem 0x43c000000000-0x43c3ffffffff]
  node   2: [mem 0x800000000000-0x803bffffffff]
  node   3: [mem 0xc00000000000-0xc03bffd35fff]
  node   3: [mem 0xc03bffd68000-0xc03bffd8bfff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [popc,vis,vis2,ASIBlkInit,fmaf,vis3,hpc,ima]
CPU CAPS: [pause,cbcond,aes,des,camellia,md5,sha1,sha256]
CPU CAPS: [sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: max_distance=0xbffcc0410000 too large for vmalloc space 0xff00000000
PERCPU: auto allocator failed (-22), falling back to page size
PERCPU: 6 8K pages/cpu @0000000100000000 s23552 r8192 d17408
SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]
Built 4 zonelists in Node order, mobility grouping on.  Total pages: 120389184
Policy zone: Normal
Kernel command line: root=/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS LANG=en_US.UTF-8 rd_NO_MD rd_LVM_LV=VolGroup/lv_swap SYSFONT=latarcyrheb-sun16 rd_LVM_LV=VolGroup/lv_root KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 4190208 bytes
log_buf_len min size: 1048576 bytes
log_buf_len: 8388608 bytes
early log buf free: 938440(89%)
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
BUG: Bad page state in process swapper  pfn:20a000000
page:0000018280000000 count:0 mapcount:-127 mapping:          (null) index:0x2
page flags: 0x1400000000000000()
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.17.0-rc4 #2
Call Trace:
 [000000000053fb40] bad_page+0xa0/0x100
 [000000000053fda0] free_pages_prepare+0x100/0x160
 [00000000005406b0] __free_pages_ok+0x10/0xe0
 [0000000000541f4c] __free_pages+0x2c/0x60
 [0000000000c944ac] __free_pages_bootmem+0xa4/0xb4
 [0000000000c980b4] free_all_bootmem+0xcc/0x12c
 [0000000000c87390] mem_init+0x6c/0xf0
 [0000000000c7e9c4] start_kernel+0x180/0x3dc
 [0000000000976f3c] tlb_fixup_done+0x98/0xbc
 [0000000000000000]           (null)
