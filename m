From: Bob Breuer <breuerr@mc.net>
Date: Fri, 15 Jul 2005 16:37:25 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <42D7E645.3020304@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jurij Smakov wrote:
> 
> Even though eliminating initrd made kernel to boot, under heavy I/O and 
> memory use it randomly corrupts the filesystem, so we are back to square 
> one.

That sounds less stable than mine.  Currently my ss20 has been up for 
about 60 hours with 2.6.12 and survived a couple kernel recompiles (I 
did a 'make clean; make all' overnight to verify).  The only problem 
I've seen is when the scsi driver goes nuts and requires a power cycle 
to recover, which seems to happen more frequently when the disk cache is 
cold, but I haven't noticed any actual corruption recently.

Here's my current configuration:
   hypersparc 150MHz, 512K cache
   192MB ram (no highmem)
   ext2/ext3 partitions
   kernel 2.6.12 compiled with gcc 3.3.4

My suspicion is that highmem may cause problems.  I'll try rearranging 
the ram this weekend and see if I can make an initrd fail.

Bob
