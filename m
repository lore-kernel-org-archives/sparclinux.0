From: Stefan Holst <mail@s-holst.de>
Date: Sun, 21 Mar 2004 18:44:46 +0000
Subject: Re: srmmu_nocache_calcsize with low memory
Message-Id: <20040321184446.GA23729@spike>
List-Id: <sparclinux.vger.kernel.org>
References: <20040321155052.GA10374@spike>
In-Reply-To: <20040321155052.GA10374@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/21, Keith M Wesolowski wrote:
> On Sun, Mar 21, 2004 at 04:50:52PM +0100, Stefan Holst wrote:
> 
> >  /* P3 XXX The 4x overuse: corroborated by /proc/meminfo. */
> > 	// if (srmmu_nocache_npages < 256) srmmu_nocache_npages = 256;
> > 	if (srmmu_nocache_npages < SRMMU_MIN_NOCACHE_PAGES)
> > 		srmmu_nocache_npages = SRMMU_MIN_NOCACHE_PAGES;
> > 
> > i didn't really understand the comment - what is the matter with that?
> 
> At one time 2.6 used 4 times as much nocache memory as 2.4 did.  It
> also had fragmentation problems and appeared to leak nocache until it
> finally ran out.  I believe I fixed most of this a few releases ago
> with the srmmu changes and the fix to fault handling (to copy the
> entire pmd instead of only one entry, which would cause more and more
> pmds to be allocated).  I no longer see more than about 1.1MB of
> nocache used even when building glibc on a 512MB system.
> Fragmentation probably still is an issue.
> 
> Therefore this comment can probably be removed; I'm just waiting to
> see if anyone still reports problems.
> 
> > after deactivating this minimum enforcement, my 4mb-system doesn't work
> > either; the calculated value (16) seems to be much too low. i did some
> > testing and found, that the system starts fine from a value around 27:
> 
> 27 would seem to be a reasonable finding for the minimum needed to
> boot.  The actual number you'll need depends mostly on the number of
> processes you run and how large they are.

ack

> > srmmu_nocache_calcsize should be fixed for low memory. but how? any
> > suggestions?
> 
> Perhaps you should just lower the minimum to 128 pages.  This stuff's
> mostly guesswork and observation anyway.  I really don't think 27 is
> enough unless you only want to run init and don't want it to do
> anything (ie a box that just sets up netfilter and then essentially
> has no userland).

i was currently using 64 pages, but didn't test with more than 3 processes
or with high load. so 128 seems to be a good tradeoff for now.
here's a small patch:


--- a/arch/sparc/mm/srmmu.c	2004-03-19 11:42:58.000000000 +0100
+++ b/arch/sparc/mm/srmmu.c	2004-03-21 19:23:32.325768328 +0100
@@ -369,8 +369,6 @@
 	srmmu_nocache_npages  		sysmemavail / SRMMU_NOCACHE_ALCRATIO / 1024 * 256;
 
- /* P3 XXX The 4x overuse: corroborated by /proc/meminfo. */
-	// if (srmmu_nocache_npages < 256) srmmu_nocache_npages = 256;
 	if (srmmu_nocache_npages < SRMMU_MIN_NOCACHE_PAGES)
 		srmmu_nocache_npages = SRMMU_MIN_NOCACHE_PAGES;
 
--- a/include/asm-sparc/vaddrs.h	2004-02-29 23:35:48.000000000 +0100
+++ b/include/asm-sparc/vaddrs.h	2004-03-21 19:24:16.248091120 +0100
@@ -17,7 +17,7 @@
 #define SRMMU_NOCACHE_VADDR	(KERNBASE + SRMMU_MAXMEM)
 				/* = 0x0fc000000 */
 /* XXX Empiricals - this needs to go away - KMW */
-#define SRMMU_MIN_NOCACHE_PAGES (550)
+#define SRMMU_MIN_NOCACHE_PAGES (128)
 #define SRMMU_MAX_NOCACHE_PAGES	(1280)
 
 /* The following constant is used in mm/srmmu.c::srmmu_nocache_calcsize()


-- 
RY  Stefan
+-----------------+----------------+
| mail@s-holst.de | www.s-holst.de |
+-----------------+----------------+
