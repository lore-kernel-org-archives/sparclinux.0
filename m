From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 31 Mar 2004 05:21:21 +0000
Subject: [PATCH 2.6] Various sparc32 cleanups
Message-Id: <1080710480.27295.41.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-a4xaNzk+4EnAGqwCIqtU"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-a4xaNzk+4EnAGqwCIqtU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

So, as part of an exercise in futility, I built 2.6 with CONFIG_SUN4=y.
Not that there appears to be any working method to boot this kernel
(yes, I do have a working sun4), but the cleanups needed were minor (and
at least partially relevant to more modern sparc32 machines).

Patch is attached. I have no idea if it works, but the bw2 fix is
obviously correct.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not 
to be published." -- Aldous Huxley's "Brave New World"

--=-a4xaNzk+4EnAGqwCIqtU
Content-Disposition: attachment; filename=linux-sun4fixups.patch
Content-Type: text/x-diff; name=linux-sun4fixups.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.4-1.278sparc2/arch/sparc/mm/Makefile.BAD	2004-03-28 17:38:23.000000000 -0600
+++ linux-2.6.4-1.278sparc2/arch/sparc/mm/Makefile	2004-03-28 17:39:38.000000000 -0600
@@ -16,8 +16,12 @@
 obj-y	+= highmem.o
 endif
 
-ifdef CONFIG_SMP
+ifdef CONFIG_SMP 
+obj-y   += nosun4c.o
+else
+ifdef CONFIG_SUN4
 obj-y   += nosun4c.o
 else
 obj-y   += sun4c.o
 endif
+endif
--- linux-2.6.4-1.278sparc2/arch/sparc/mm/nosrmmu.c.BAD	2004-03-28 18:26:55.000000000 -0600
+++ linux-2.6.4-1.278sparc2/arch/sparc/mm/nosrmmu.c	2004-03-28 18:27:11.000000000 -0600
@@ -46,6 +46,8 @@
 {
 }
 
+void *srmmu_nocache_pool;
+
 void __init srmmu_end_memory(unsigned long memory_size, unsigned long *mem_end_p)
 {
 	return 0;
--- linux-2.6.4-1.278sparc2/arch/sparc/mm/nosun4c.c.BAD	2004-03-28 18:29:05.000000000 -0600
+++ linux-2.6.4-1.278sparc2/arch/sparc/mm/nosun4c.c	2004-03-28 18:28:57.000000000 -0600
@@ -75,3 +75,7 @@
 {
 	should_not_happen();
 }
+
+void sun4c_grow_kernel_ring(void)
+{
+}
--- linux-2.6.4-1.278sparc2/drivers/video/bw2.c.BAD	2004-03-28 18:10:18.000000000 -0600
+++ linux-2.6.4-1.278sparc2/drivers/video/bw2.c	2004-03-28 18:10:26.000000000 -0600
@@ -321,7 +321,7 @@
 		resp = &res;
 		all->info.var.xres = all->info.var.xres_virtual = 1152;
 		all->info.var.yres = all->info.var.yres_virtual = 900;
-		all->info.bits_per_pixel = 1;
+		all->info.var.bits_per_pixel = 1;
 		linebytes = 1152 / 8;
 	} else
 #else

--=-a4xaNzk+4EnAGqwCIqtU--

