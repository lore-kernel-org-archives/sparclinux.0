From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 30 Dec 2003 10:37:05 +0000
Subject: [2.4 RFC] Do not allow pkmap and fixmaps to overlap
Message-Id: <20031230103705.GA1797@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On SMP systems, the fixmap and pkmap regions can (will) overlap.
Although x86 has a check for this condition indicating the box will
crash if it exists, I found it trying to track down an unrelated
(non-SMP-specific) bug rather than by directly observing any ill
effects.  Therefore I need some people to test and tell me if this has
any effect (positive or negative).

If you want to understand what's going on here, I have a vaddr map at
http://foobazco.org/~wesolows/sparc-25-virtmap.

I have some more major surgery in mind for 2.6, which is also
affected, but this simple fixup seems more appropriate for 2.4.
Comments?

=== arch/sparc/mm/srmmu.c 1.17 vs edited ==--- 1.17/arch/sparc/mm/srmmu.c	Mon Jul 21 04:57:23 2003
+++ edited/arch/sparc/mm/srmmu.c	Tue Dec 30 02:20:28 2003
@@ -356,8 +356,13 @@
 	srmmu_nocache_end = SRMMU_NOCACHE_VADDR + srmmu_nocache_size;
 	fix_kmap_begin = srmmu_nocache_end;
 	fix_kmap_end = fix_kmap_begin + (KM_TYPE_NR * NR_CPUS - 1) * PAGE_SIZE;
-	pkmap_base = SRMMU_NOCACHE_VADDR + srmmu_nocache_size + 0x40000;
+	pkmap_base = SRMMU_NOCACHE_VADDR + srmmu_nocache_size + 0x400000;
 	pkmap_base_end = pkmap_base + LAST_PKMAP * PAGE_SIZE;
+
+	if (fix_kmap_end >= pkmap_base) {
+		prom_printf("fix_kmap and pkmap areas overlap!\n");
+		prom_halt();
+	}
 
 	/* printk("system memory available = %luk\nnocache ram size = %luk\n",
 		sysmemavail, srmmu_nocache_size / 1024); */


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
