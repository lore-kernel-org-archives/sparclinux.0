From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 02 Feb 2005 20:04:09 +0000
Subject: [PATCH] A BTFIXUP'd fix for pte_read()
Message-Id: <20050202200409.GA30839@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

Here's my attempt at taking Bob Breuer's patch and adding in some of the
BTFIXUP magic that sparc32 needs. I'm running the current BK kernel with
this patch on my SS20, and things seem to work. The current kernel
complains during bootup and shutdown about accessing the system clock,
a problem I am guessing is related to changes elsewhere in the kernel.

Art Haas

=== arch/sparc/mm/srmmu.c 1.49 vs edited ==--- 1.49/arch/sparc/mm/srmmu.c	2005-01-20 23:02:11 -06:00
+++ edited/arch/sparc/mm/srmmu.c	2005-02-02 09:39:49 -06:00
@@ -2197,6 +2197,7 @@
 	BTFIXUPSET_CALL(free_pgd_fast, srmmu_free_pgd_fast, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(get_pgd_fast, srmmu_get_pgd_fast, BTFIXUPCALL_NORM);
 
+	BTFIXUPSET_HALF(pte_readi, SRMMU_NOREAD);
 	BTFIXUPSET_HALF(pte_writei, SRMMU_WRITE);
 	BTFIXUPSET_HALF(pte_dirtyi, SRMMU_DIRTY);
 	BTFIXUPSET_HALF(pte_youngi, SRMMU_REF);
=== include/asm-sparc/pgtable.h 1.24 vs edited ==--- 1.24/include/asm-sparc/pgtable.h	2004-12-22 03:36:07 -06:00
+++ edited/include/asm-sparc/pgtable.h	2005-02-02 09:51:07 -06:00
@@ -186,9 +186,16 @@
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
+BTFIXUPDEF_HALF(pte_readi)
 BTFIXUPDEF_HALF(pte_writei)
 BTFIXUPDEF_HALF(pte_dirtyi)
 BTFIXUPDEF_HALF(pte_youngi)
+
+extern int pte_read(pte_t pte) __attribute_const__;
+extern __inline__ int pte_read(pte_t pte)
+{
+	return !(pte_val(pte) & BTFIXUP_HALF(pte_readi));
+}
 
 extern int pte_write(pte_t pte) __attribute_const__;
 extern __inline__ int pte_write(pte_t pte)
=== include/asm-sparc/pgtsrmmu.h 1.12 vs edited ==--- 1.12/include/asm-sparc/pgtsrmmu.h	2004-07-12 01:53:22 -05:00
+++ edited/include/asm-sparc/pgtsrmmu.h	2005-02-01 10:45:31 -06:00
@@ -73,6 +73,7 @@
 #define SRMMU_CACHE        0x80
 #define SRMMU_DIRTY        0x40
 #define SRMMU_REF          0x20
+#define SRMMU_NOREAD       0x10
 #define SRMMU_EXEC         0x08
 #define SRMMU_WRITE        0x04
 #define SRMMU_VALID        0x02 /* SRMMU_ET_PTE */
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
