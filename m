From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 30 Dec 2011 14:16:50 +0000
Subject: Re: [PATCH] sparc32: remove unused file: include/asm/pgtsun4.h
Message-Id: <20111230141650.GA4686@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111230123521.GA4478@merkur.ravnborg.org>
In-Reply-To: <20111230123521.GA4478@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Dec 30, 2011 at 03:10:33PM +0100, Sam Ravnborg wrote:
> On Fri, Dec 30, 2011 at 11:44:28PM +1100, Julian Calaby wrote:
> > Sam,
> > 
> > I understand if this isn't used at all, but this seems to be Sun4C
> > stuff, so why isn't it used - are these defines defined elsewhere?
> 
> The SUN4C stuff is defined in arch/sparc/include/asm/pgtsun4c.h

The diff between pgtsun.h and pgtsun4c.h is very small.
The relevant part of the diff is below:

@@ -9,10 +10,10 @@
 #include <asm/contregs.h>

 /* PMD_SHIFT determines the size of the area a second-level page table can map */
-#define SUN4C_PMD_SHIFT       22
+#define SUN4C_PMD_SHIFT       23

 /* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define SUN4C_PGDIR_SHIFT       22
+#define SUN4C_PGDIR_SHIFT       23
 #define SUN4C_PGDIR_SIZE        (1UL << SUN4C_PGDIR_SHIFT)
 #define SUN4C_PGDIR_MASK        (~(SUN4C_PGDIR_SIZE-1))
 #define SUN4C_PGDIR_ALIGN(addr) (((addr)+SUN4C_PGDIR_SIZE-1)&SUN4C_PGDIR_MASK)
@@ -23,9 +24,9 @@
 #define SUN4C_REAL_PGDIR_MASK        (~(SUN4C_REAL_PGDIR_SIZE-1))
 #define SUN4C_REAL_PGDIR_ALIGN(addr) (((addr)+SUN4C_REAL_PGDIR_SIZE-1)&SUN4C_REAL_PGDIR_MASK)

-/* 16 bit PFN on sun4c */
-#define SUN4C_PFN_MASK 0xffff
-
+/* 19 bit PFN on sun4 */
+#define SUN4C_PFN_MASK 0x7ffff
+
 /* Don't increase these unless the structures in sun4c.c are fixed */
 #define SUN4C_MAX_SEGMAPS 256
 #define SUN4C_MAX_CONTEXTS 16


I stripped aways the parts which was in comments and white-space only.

	Sam
