From: Bob Breuer <breuerr@mc.net>
Date: Wed, 09 Mar 2011 05:25:32 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <4D770F4C.6040701@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Marcel van Nies wrote:
> Hi,
> 
> The good news:
> sparc-next-2.6 with commit 4d14a459857bd151ecbd14bcd37b4628da00792b reverted
> does NOT segfault. I did not apply the genirq patch yet.
> 
> The bad news:
> Segfault gone, say hello to EXT2 read failure   :o(
> 
> I'll rebuild this kernel with the esp_debug.patch Sam sent a couple of days ago.
> 
> 
> [    0.233333] esp: esp0, regs[fd00a000:fd009000] irq[36]
> [    0.236666] esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
> [    3.243333] scsi0 : esp
> [    3.483332] scsi 0:0:1:0: Direct-Access     FUJITSU  MAP3735N
> SUN72G  0401 PQ: 0 ANSI: 4
> [    3.486666] scsi target0:0:1: Beginning Domain Validation
> [    3.493332] scsi target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
> [    3.499999] scsi target0:0:1: Domain Validation skipping write tests
> [    3.503332] scsi target0:0:1: Ending Domain Validation
> [    3.743332] scsi 0:0:3:0: Direct-Access     FUJITSU  MAP3735N
> SUN72G  0401 PQ: 0 ANSI: 4
> [    3.746666] scsi target0:0:3: Beginning Domain Validation
> [    3.753332] scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
> [    3.756666] scsi target0:0:3: Domain Validation skipping write tests
> [    3.759999] scsi target0:0:3: Ending Domain Validation
> [    4.469999] esp: esp1, regs[fd00c000:fd00b000] irq[53]
> [    4.473332] esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
> [    7.479999] scsi1 : esp
> ...
> [   11.029998] sd 0:0:1:0: [sda] 143374738 512-byte logical blocks:
> (73.4 GB/68.3 GiB)
> [   11.033332] sd 0:0:3:0: [sdb] 143374738 512-byte logical blocks:
> (73.4 GB/68.3 GiB)
> [   11.036665] sd 0:0:1:0: [sda] Write Protect is off
> [   11.043332] sd 0:0:1:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [   11.046665] sd 0:0:3:0: [sdb] Write Protect is off
> [   11.053332] sd 0:0:3:0: [sdb] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [   11.066665]  sda: sda1 sda2 sda3
> [   11.073332]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
> [   11.089998] sd 0:0:1:0: [sda] Attached SCSI disk
> [   11.093332] sd 0:0:3:0: [sdb] Attached SCSI disk
> [   11.106665] EXT3-fs: barriers not enabled
> [   11.113332] kjournald starting.  Commit interval 5 seconds
> [   11.116665] EXT3-fs (sdb4): mounted filesystem with ordered data mode
> [   11.119998] VFS: Mounted root (ext3 filesystem) readonly on device 8:20.
> [   11.123332] Freeing unused kernel memory: 108k freed
> INIT: version 2.86 booting
> [   12.673332] NET: Registered protocol family 1
> 
> Gentoo Linux; http://www.gentoo.org/
>  Copyright 1999-2007 Gentoo Foundation; Distributed under the GPLv2
> 
>  * Mounting proc at /proc ...                                             [ ok ]
>  * Mounting sysfs at /sys ...                                             [ ok ]
>  * Mounting /dev for udev ...                                             [ ok ]
> ...
> blahblah
> ...
>  * Checking root filesystem ...fsck.ext3: No such file or directory
> while trying to open /dev/sdb4


Check if the device node for /dev/sdb4 exists.

For me, udev will sometimes fail to create a device node with the latest
kernel.  This is with a SuperSparc cpu, so it's not hyperSparc related.
 Of course, it could just be my udev acting up, as I get error messages
from udev such as:

Starting udev: udevd[88]: udev_event_run: fork of child failed: Invalid
argument
udevd[88]: udev_event_run: fork of child failed: Invalid argument
udevd[88]: udev_event_run: fork of child failed: Invalid argument
udevd[88]: udev_event_run: fork of child failed: Invalid argument

I'm not sure whether the invalid argument is a udev problem, userspace
incompatibility, kernel bug, or a kernel feature I left out.

Bob

