From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 08 Apr 2011 08:22:34 +0000
Subject: Re: linux-image-2.6.26-1-sparc64-smp: [sparc] SunFire480R cassini network driver kernel panic
Message-Id: <20110408082234.GA11528@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 05, 2011 at 05:20:21PM +0200, Hermann Lauer wrote:
> Tried that now (thanks for the hint), boot hangs after output below.
> Any ideas for debugging ?

Just found the "initcall_debug=1 ignore_loglevel" suggested by davem
during the last debugging session with this machine.

Tail of the output is below for completeness, thought I feel
I should try the latest stable vanilla kernel when time permits.

Or anybody want's to suggest a git version (which URL to clone from) ?

Thanks folks,
  Hermann

> Sun Fire 480R, No Keyboard
> Copyright 2007 Sun Microsystems, Inc.  All rights reserved.
> OpenBoot 4.22.34, 16384 MB memory installed, Serial #...
> Ethernet address ..., Host ID: ...
> 
> {2} ok boot gem:dhcp -p 
> Boot device: /pci@8,600000/network@2:dhcp  File and args: -p
> Timed out waiting for BOOTP/DHCP reply
> Timed out waiting for BOOTP/DHCP reply
> Timed out waiting for BOOTP/DHCP reply
> |
> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.34 2007/07/23 13:01'
> [    0.000000] PROMLIB: Root node compatible: 
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 2.6.37-2-sparc64 (Debian 2.6.37-2) (ben@decadent.org.uk) (gcc version 4.4.5 (Debian 4.4.5-12) ) #1 Sun Feb 27 11:28:28 UTC 2011
...
[  211.823297] calling  setup_vmstat+0x0/0x90 @ 1
[  211.823332] initcall setup_vmstat+0x0/0x90 returned 0 after 15 usecs
[  211.823354] calling  mm_sysfs_init+0x0/0x30 @ 1
[  211.823384] initcall mm_sysfs_init+0x0/0x30 returned 0 after 10 usecs
[  211.823407] calling  proc_vmalloc_init+0x0/0x30 @ 1
[  211.823431] initcall proc_vmalloc_init+0x0/0x30 returned 0 after 3 usecs
[  211.823454] calling  memblock_init_debugfs+0x0/0x70 @ 1
[  211.823484] initcall memblock_init_debugfs+0x0/0x70 returned 0 after 9 usecs
[  211.823507] calling  procswaps_init+0x0/0x30 @ 1
[  211.823530] initcall procswaps_init+0x0/0x30 returned 0 after 3 usecs
[  211.823552] calling  hugetlb_init+0x0/0x4dc @ 1
[  211.823576] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[  211.823620] initcall hugetlb_init+0x0/0x4dc returned 0 after 46 usecs
[  211.823643] calling  ksm_init+0x0/0x154 @ 1
[  211.823775] initcall ksm_init+0x0/0x154 returned 0 after 107 usecs
[  211.823797] calling  slab_proc_init+0x0/0x30 @ 1
[  211.823823] initcall slab_proc_init+0x0/0x30 returned 0 after 6 usecs
[  211.823843] calling  slab_sysfs_init+0x0/0x130 @ 1
[  211.828581] initcall slab_sysfs_init+0x0/0x130 returned 0 after 4606 usecs
[  211.828604] calling  fcntl_init+0x0/0x30 @ 1
[  211.828636] initcall fcntl_init+0x0/0x30 returned 0 after 13 usecs
[  211.828657] calling  proc_filesystems_init+0x0/0x30 @ 1
[  211.828686] initcall proc_filesystems_init+0x0/0x30 returned 0 after 9 usecs
[  211.828707] calling  fsnotify_mark_init+0x0/0x44 @ 1
[  211.828780] initcall fsnotify_mark_init+0x0/0x44 returned 0 after 50 usecs
[  211.828802] calling  dnotify_init+0x0/0x7c @ 1
[  211.828857] initcall dnotify_init+0x0/0x7c returned 0 after 34 usecs
[  211.828878] calling  inotify_user_setup+0x0/0x7c @ 1
[  211.828924] initcall inotify_user_setup+0x0/0x7c returned 0 after 26 usecs
[  211.828946] calling  fanotify_user_setup+0x0/0x58 @ 1
[  211.829073] initcall fanotify_user_setup+0x0/0x58 returned 0 after 103 usecs
[  211.829096] calling  aio_setup+0x0/0xb4 @ 1
[  211.829280] initcall aio_setup+0x0/0xb4 returned 0 after 159 usecs
[  211.829302] calling  proc_locks_init+0x0/0x30 @ 1
[  211.829327] initcall proc_locks_init+0x0/0x30 returned 0 after 6 usecs
[  211.829348] calling  init_sys32_ioctl+0x0/0x30 @ 1
[  211.829674] initcall init_sys32_ioctl+0x0/0x30 returned 0 after 300 usecs
[  211.829695] callin
