From: Bob Breuer <breuerr@mc.net>
Date: Wed, 12 Jan 2005 06:30:19 +0000
Subject: Re: Current BK kernel error
Message-Id: <41E4C3FB.8070806@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050111143605.GC4514@artsapartment.org>
In-Reply-To: <20050111143605.GC4514@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
> 
> Ship me what you've got and I'll test it on sun4c and BTFIXUP-ize it.
> 

Ok, how about this patch to start from?


diff -urp linux-2.6.10-bk8-clean/include/asm-sparc/pgtable.h linux-2.6.10-bk8/include/asm-sparc/pgtable.h
--- linux-2.6.10-bk8-clean/include/asm-sparc/pgtable.h	2005-01-12 00:16:39.000000000 -0600
+++ linux-2.6.10-bk8/include/asm-sparc/pgtable.h	2005-01-12 00:15:21.000000000 -0600
@@ -186,10 +186,21 @@ BTFIXUPDEF_CALL(void, pgd_clear, pgd_t *
   * The following only work if pte_present() is true.
   * Undefined behaviour if not..
   */
+//BITFIXUPDEF_????(pte_readi)
  BTFIXUPDEF_HALF(pte_writei)
  BTFIXUPDEF_HALF(pte_dirtyi)
  BTFIXUPDEF_HALF(pte_youngi)

+extern int pte_read(pte_t pte) __attribute_const__;
+extern __inline__ int pte_read(pte_t pte)
+{
+#if 0 // SUN4/SUN4C
+	return pte_val(pte) & _SUN4C_PAGE_READ;
+#else // SUN4M
+	return !(pte_val(pte) & SRMMU_NOREAD);
+#endif
+}
+
  extern int pte_write(pte_t pte) __attribute_const__;
  extern __inline__ int pte_write(pte_t pte)
  {
diff -urp linux-2.6.10-bk8-clean/include/asm-sparc/pgtsrmmu.h linux-2.6.10-bk8/include/asm-sparc/pgtsrmmu.h
--- linux-2.6.10-bk8-clean/include/asm-sparc/pgtsrmmu.h	2004-10-18 16:53:46.000000000 -0500
+++ linux-2.6.10-bk8/include/asm-sparc/pgtsrmmu.h	2005-01-12 00:09:44.000000000 -0600
@@ -73,6 +73,7 @@
  #define SRMMU_CACHE        0x80
  #define SRMMU_DIRTY        0x40
  #define SRMMU_REF          0x20
+#define SRMMU_NOREAD       0x10
  #define SRMMU_EXEC         0x08
  #define SRMMU_WRITE        0x04
  #define SRMMU_VALID        0x02 /* SRMMU_ET_PTE */
