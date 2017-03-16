From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 16 Mar 2017 12:21:06 +0000
Subject: Re: Retrieving disk info from sunvdc using udevadm
Message-Id: <4fa570e3-06a5-c460-8600-632dfd634cb1@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
In-Reply-To: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/16/2017 01:15 PM, Anatoly Pugachev wrote:
> wouldn't it be easier to patch d-i (userspace) to add support for
> "ID_FS_TYPE=iso9660" as /dev/cdrom (besides of "ID_CDROM=1"), instead
> of patching kernel (sunvdc.c) sources?

We have discussed this shortly, but we haven't really agreed on whether
this would be a clean solution after all. I mean, if you attach an ISO
file to a virtual CD-ROM drive, the kernel should report the corresponding
block device to be an actual CD-ROM drive, shouldn't it?

> # udevadm info -q env -p /sys/block/sr0
> (...)
> ID_CDROM=1

See, qemu does it correctly, sunvdc does not. And I assume all other type
of virtualization software (VirtualBox, VMWare) reports the right block
device type either. Otherwise we would have already seen lots of bug
reports regarding this. So I don't think it's justified to add a quirk for
sunvdc, is it?

> dmesg cut:
> (...)

I'm not sure how this is relevant here?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
