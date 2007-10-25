From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Oct 2007 16:43:05 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071025164305.GA22505@keid.carnet.hr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
To: sparclinux@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 25, 2007 at 05:07:36PM +0200, joy wrote:
> > If you try, within that troublesome build-root, a few times to try to
> > fork off a couple hundred:
> > 
> > 	dpkg-query --something python-2.5
> > 
> > or whatever, can you get some of processes to wedge under that
> > build root?
> 
> I did this in a chrooted bash:
> 
> for i in $(seq 0 100); do (dpkg-query -s python2.5-minimal > /dev/null &); done
> 
> And now the machine went catatonic. :(
> 
> Thankfully the console is still vaguely operational - I can enter my
> username to log in, but I can't get the Password prompt to appear.
> Magic SysRq still works - if you need any output from it, tell me.

The machine continued in this state for a couple of hours or so, it didn't
come back to life. When I went to check up on it, the kernel showed one
message on the console - OOM killer killed a make process. I then gave up,
used SysRq to S+U+B, and it booted again, and I was able to retrieve the
following data from kern.log that is in the attachment. Hope that helps.

-- 
     2. That which causes joy or happiness.

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lebrun.kern.log"

Oct 25 17:04:09 lebrun kernel: SysRq : Emergency Sync
Oct 25 17:04:20 lebrun kernel: SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice showPc show-all-timers(Q) unRaw Sync showTasks Unmount shoW-blocked-tasks 
Oct 25 17:04:20 lebrun kernel: SysRq : Show Memory
Oct 25 17:04:20 lebrun kernel: Mem-info:
Oct 25 17:04:20 lebrun kernel: Normal per-cpu:
Oct 25 17:04:20 lebrun kernel: CPU    0: Hot: hi:   90, btch:  15 usd:   0   Cold: hi:   30, btch:   7 usd:   0
Oct 25 17:04:20 lebrun kernel: CPU    1: Hot: hi:   90, btch:  15 usd:   4   Cold: hi:   30, btch:   7 usd:  24
Oct 25 17:04:20 lebrun kernel: Active:202209 inactive:46687 dirty:39 writeback:279 unstable:0
Oct 25 17:04:20 lebrun kernel:  free:723 slab:2826 mapped:2986 pagetables:875 bounce:0
Oct 25 17:04:20 lebrun kernel: Normal free:5616kB min:5760kB low:7200kB high:8640kB active:1619760kB inactive:371344kB present:2077352kB pages_scanned:178 all_unreclaimable? no
Oct 25 17:04:20 lebrun kernel: lowmem_reserve[]: 0 0
Oct 25 17:04:21 lebrun kernel: Normal: 780*8kB 11*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB = 6512kB
Oct 25 17:04:21 lebrun kernel: Swap cache: add 251630, delete 187227, find 26426/42924, race 80+86
Oct 25 17:04:21 lebrun kernel: Free swap  = 174880kB
Oct 25 17:04:24 lebrun kernel: Total swap = 1048688kB
Oct 25 17:04:24 lebrun kernel: Free swap:       174648kB
Oct 25 17:04:24 lebrun kernel: 261865 pages of RAM
Oct 25 17:04:24 lebrun kernel: 3001 reserved pages
Oct 25 17:04:24 lebrun kernel: 155176 pages shared
Oct 25 17:04:24 lebrun kernel: 64407 pages swap cached
Oct 25 17:04:24 lebrun kernel: 39 pages dirty
Oct 25 17:04:24 lebrun kernel: 124 pages writeback
Oct 25 17:04:24 lebrun kernel: 2986 pages mapped
Oct 25 17:04:24 lebrun kernel: 2826 pages slab
Oct 25 17:04:24 lebrun kernel: 875 pages pagetables
Oct 25 17:05:01 lebrun kernel: SysRq : Emergency Sync
Oct 25 17:05:04 lebrun kernel: SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice showPc show-all-timers(Q) unRaw Sync showTasks Unmount shoW-blocked-tasks 
Oct 25 17:05:07 lebrun kernel: SysRq : Show Blocked State
Oct 25 17:05:07 lebrun kernel:   task                        PC stack   pid father
Oct 25 17:05:07 lebrun kernel: kswapd0       D 0000000000528bc8     0   181      2
Oct 25 17:05:07 lebrun kernel: Call Trace:
Oct 25 17:05:08 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:05:08 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] ges+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3924      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000014f8c] 0x14f94
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3926      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3928      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3930      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3932      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e1be34] 0xf7e1be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3934      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3936      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e67e34] 0xf7e67e3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3938      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e5fe34] 0xf7e5fe3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3940      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3944      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3946      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000014f8c] 0x14f94
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3948      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e6be34] 0xf7e6be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3950      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015064] 0x1506c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3952      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e7be34] 0xf7e7be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3958      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3960      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015064] 0x1506c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3962      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000014f8c] 0x14f94
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3964      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e3be34] 0xf7e3be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3966      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e7be34] 0xf7e7be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3968      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e2be34] 0xf7e2be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3970      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3972      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e3be34] 0xf7e3be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3974      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [00000000004973c4] handle_mm_fault+0x40c/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3976      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e7fe34] 0xf7e7fe3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 00000000004873bc     0  3978      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [00000000004873bc] sync_page+0x6c/0x74
Oct 25 17:12:13 lebrun kernel:  [0000000000625a8c] __wait_on_bit_lock+0x58/0x90
Oct 25 17:12:13 lebrun kernel:  [0000000000487334] __lock_page+0x54/0x5c
Oct 25 17:12:13 lebrun kernel:  [0000000000497450] handle_mm_fault+0x498/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3980      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3982      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015064] 0x1506c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3984      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e6fe34] 0xf7e6fe3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3988      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7ed7e34] 0xf7ed7e3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3990      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e4be34] 0xf7e4be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3992      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7de3e34] 0xf7de3e3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3994      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3996      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015064] 0x1506c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  3998      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e6fe34] 0xf7e6fe3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  4000      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049f50c] read_swap_cache_async+0x40/0x150
Oct 25 17:12:13 lebrun kernel:  [0000000000495908] swapin_readahead+0x3c/0x7c
Oct 25 17:12:13 lebrun kernel:  [00000000004973b4] handle_mm_fault+0x3fc/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [0000000000015078] 0x15080
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  4003      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e4be34] 0xf7e4be3c
Oct 25 17:12:13 lebrun kernel: dpkg-query    D 0000000000528bc8     0  4005      1
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000049715c] handle_mm_fault+0x1a4/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20
Oct 25 17:12:13 lebrun kernel:  [00000000f7e97e34] 0xf7e97e3c
Oct 25 17:12:13 lebrun kernel: mrtg          D 0000000000528bc8     0  4022   4021
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000048d0f0] __get_free_pages+0x3c/0xa8
Oct 25 17:12:13 lebrun kernel:  [000000000045d168] copy_process+0x78/0xf04
Oct 25 17:12:13 lebrun kernel:  [000000000045e078] do_fork+0x84/0x204
Oct 25 17:12:13 lebrun kernel:  [0000000000406294] linux_sparc_syscall32+0x3c/0x40
Oct 25 17:12:13 lebrun kernel:  [00000000f7d62cd0] 0xf7d62cd8
Oct 25 17:12:13 lebrun kernel: cc1plus       D 0000000000528bc8     0  5169   5168
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [0000000000487838] __grab_cache_page+0x58/0xa4
Oct 25 17:12:13 lebrun kernel:  [00000000004f44d8] ext3_write_begin+0x38/0x19c
Oct 25 17:12:13 lebrun kernel:  [0000000000488548] generic_file_buffered_write+0xe0/0x610
Oct 25 17:12:13 lebrun kernel:  [0000000000488da8] __generic_file_aio_write_nolock+0x330/0x370
Oct 25 17:12:13 lebrun kernel:  [0000000000488e38] generic_file_aio_write+0x50/0xb8
Oct 25 17:12:13 lebrun kernel:  [00000000004ef8dc] ext3_file_write+0x24/0xcc
Oct 25 17:12:13 lebrun kernel: sshd          D 0000000000528bc8     0  5171   2187
Oct 25 17:12:13 lebrun kernel: Call Trace:
Oct 25 17:12:13 lebrun kernel:  [00000000006258e0] io_schedule+0x2c/0x38
Oct 25 17:12:13 lebrun kernel:  [0000000000528bc8] get_request_wait+0x11c/0x15c
Oct 25 17:12:13 lebrun kernel:  [000000000052a220] __make_request+0x5f0/0x6a8
Oct 25 17:12:13 lebrun kernel:  [0000000000526bac] generic_make_request+0x2f8/0x31c
Oct 25 17:12:13 lebrun kernel:  [0000000000526cd4] submit_bio+0x104/0x10c
Oct 25 17:12:13 lebrun kernel:  [000000000049f30c] swap_writepage+0xa4/0xb4
Oct 25 17:12:13 lebrun kernel:  [00000000004918c4] shrink_page_list+0x410/0x6f4
Oct 25 17:12:13 lebrun kernel:  [00000000004922c8] shrink_zone+0x720/0xa38
Oct 25 17:12:13 lebrun kernel:  [0000000000492de8] try_to_free_pages+0x144/0x258
Oct 25 17:12:13 lebrun kernel:  [000000000048cf34] __alloc_pages+0x1b0/0x330
Oct 25 17:12:13 lebrun kernel:  [000000000048f310] __do_page_cache_readahead+0x94/0x1d0
Oct 25 17:12:13 lebrun kernel:  [00000000004894c4] filemap_fault+0x140/0x374
Oct 25 17:12:13 lebrun kernel:  [0000000000495328] __do_fault+0x5c/0x4d8
Oct 25 17:12:13 lebrun kernel:  [0000000000497350] handle_mm_fault+0x398/0x7cc
Oct 25 17:12:13 lebrun kernel:  [000000000044e084] do_sparc64_fault+0x314/0x594
Oct 25 17:12:13 lebrun kernel:  [000000000040794c] sparc64_realfault_common+0x18/0x20

--zYM0uCDKw75PZbzx--
