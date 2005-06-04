From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 04 Jun 2005 05:18:33 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6 work]
Message-Id: <20050604051833.GB31508@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jun 04, 2005 at 12:21:22AM -0400, Jurij Smakov wrote:
> I have tried to dig a little bit more on this issue, with some success. 
> It appears that initrd does not mount because something is wrong with the
> __copy_1page function, invoked by memcpy() for copying page-sized chunks.
> It is used in fs/cramfs/inode.c to read in the superblock of the cramfs 
> filesystem and, surprisingly, in this process first 16 bytes (containing 
> the magic cramfs number, among other things), get lost somehow. After I've 
> replaced a call to __copy_1page with a call to __memcpy in 
> include/asm-sparc/string.h, initrd mounted, however boot still fails. The 
> next problem is that /linuxrc script from initrd is not executed as it 
> should. This script is supposed to save real-root-device from /proc and 
> set the real-root-device to ramdisk, where initrd is located (it all 
> happens in do_mounts_initrd.c). However, the execve call to /linuxrc 
> quietly fails, and the script is never executed. After that kernel tries 
> to immediately mount /dev/sda1 (which is the real root) and fails, because 
> the scsi modules have not been loaded. So it now looks like this:
[...]

This is a tremendous amount of progress. I'll look at __copy_1page,
though others should do likewise as well.


-- wli
