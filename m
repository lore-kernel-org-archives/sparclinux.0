From: Ben Collins <bcollins@debian.org>
Date: Wed, 14 Jul 2004 14:48:41 +0000
Subject: SILO 1.4.8 released, fixes initrd issues
Message-Id: <20040714144841.GF667@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks to Dieter Jurzitza for all his testing. This version fixes the
initrd loading when physical memory base wasn't 0x0.

The problem comes from the fact that the sparc64 checking for
sparc_ramdisk_start always expected the phys location passed from SILO to
be relative to the physical memory base. Not sure why that is, but
obviously SILO needs to adhere to it.

Maybe someday I'll clean all that up. The kernel has one other check for
the initrd being located above the kernel and adjusting the address based
on KERNBASE, which seems just as bogus as the relative-to-phys-base thing.

Over the next week I'll try to finish off the ability for sparc64 to use
64-bit addresses for initrd, make that sane, and leave the old stuff to
maybe get removed as cruft one day.

Download here:

http://www.sparc-boot.org/pub/silo/

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
