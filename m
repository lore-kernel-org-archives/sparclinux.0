From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 04 Jun 2005 04:21:22 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6
Message-Id: <Pine.LNX.4.61.0506040011390.7379@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have tried to dig a little bit more on this issue, with some success. 
It appears that initrd does not mount because something is wrong with the
__copy_1page function, invoked by memcpy() for copying page-sized chunks.
It is used in fs/cramfs/inode.c to read in the superblock of the cramfs 
filesystem and, surprisingly, in this process first 16 bytes (containing 
the magic cramfs number, among other things), get lost somehow. After I've 
replaced a call to __copy_1page with a call to __memcpy in 
include/asm-sparc/string.h, initrd mounted, however boot still fails. The 
next problem is that /linuxrc script from initrd is not executed as it 
should. This script is supposed to save real-root-device from /proc and 
set the real-root-device to ramdisk, where initrd is located (it all 
happens in do_mounts_initrd.c). However, the execve call to /linuxrc 
quietly fails, and the script is never executed. After that kernel tries 
to immediately mount /dev/sda1 (which is the real root) and fails, because 
the scsi modules have not been loaded. So it now looks like this:

RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2580KiB [1 disk] into ram disk... done.
VFS: Mounted root (cramfs filesystem) readonly.
VFS: Cannot open root device "sda1" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

I don't know how I should proceed with debugging this.

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
