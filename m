From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 21 Apr 2011 14:21:39 +0000
Subject: [PATCH] sparc32: removed unused code, implemented by generic code
Message-Id: <1303395699-6929-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/lib/Makefile   |    1 -
 arch/sparc/lib/rwsem_32.S |  224 ---------------------------------------------
 2 files changed, 0 insertions(+), 225 deletions(-)
 delete mode 100644 arch/sparc/lib/rwsem_32.S

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 846d1c4..7f01b8f 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -15,7 +15,6 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
 lib-y                 += atomic_$(BITS).o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
-lib-$(CONFIG_SPARC32) += rwsem_32.o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
diff --git a/arch/sparc/lib/rwsem_32.S b/arch/sparc/lib/rwsem_32.S
deleted file mode 100644
index c998f6f..0000000
--- a/arch/sparc/lib/rwsem_32.S
+++ /dev/null
@@ -1,224 +0,0 @@
-/*
- * Assembly part of rw semaphores.
- *
- * Copyright (C) 1999 Jakub Jelinek (jakub@redhat.com)
- */
-
-#include <asm/ptrace.h>
-#include <asm/psr.h>
-
-	.section .sched.text, "ax"
-	.align	4
-
-	.globl		___down_read
-___down_read:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	nop
-	nop
-	nop
-#ifdef CONFIG_SMP
-#if !(defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP))
-1:	ldstub		[%g1 + 4], %g7
-#else
-1:	set		4, %g7
-	ldstuba		[%g1 + %g7] 1, %g7  /* ASI_LEON23_DCACHE_MISS */
-#endif
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	sub		%g7, 1, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	sub		%g7, 1, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	add		%g7, 1, %g7
-	nop
-	nop
-	subcc		%g7, 1, %g7
-	bneg		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	bcs		4f
-	 mov		%g5, %l5
-	call		down_read_failed
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		___down_read
-	 restore	%l5, %g0, %g5
-4:	call		down_read_failed_biased
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
-
-	.globl		___down_write
-___down_write:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	sethi		%hi(0x01000000), %g2
-	nop
-	nop
-#ifdef CONFIG_SMP
-#if !(defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP))
-1:	ldstub		[%g1 + 4], %g7
-#else
-1:	set		4, %g7
-	ldstuba		[%g1 + %g7] 1, %g7 /* ASI_LEON23_DCACHE_MISS */
-#endif
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	sub		%g7, %g2, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	sub		%g7, %g2, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	add		%g7, %g2, %g7
-	nop
-	nop
-	subcc		%g7, %g2, %g7
-	bne		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	bcs		4f
-	 mov		%g5, %l5
-	call		down_write_failed
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		___down_write
-	 restore	%l5, %g0, %g5
-4:	call		down_write_failed_biased
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
-
-	.text
-	.globl		___up_read
-___up_read:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	nop
-	nop
-	nop
-#ifdef CONFIG_SMP
-#if !(defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP))
-1:	ldstub		[%g1 + 4], %g7
-#else
-1:	set		4, %g7
-	ldstuba		[%g1 + %g7] 1, %g7 /* ASI_LEON23_DCACHE_MISS */
-#endif
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	add		%g7, 1, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	add		%g7, 1, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	nop
-	nop
-	nop
-	cmp		%g7, 0
-	be		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	mov		%g5, %l5
-	clr		%o1
-	call		__rwsem_wake
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
-
-	.globl		___up_write
-___up_write:
-	rd		%psr, %g3
-	nop
-	nop
-	nop
-	or		%g3, PSR_PIL, %g7
-	wr		%g7, 0, %psr
-	sethi		%hi(0x01000000), %g2
-	nop
-	nop
-#ifdef CONFIG_SMP
-#if !(defined(CONFIG_SPARC_LEON) && defined(CONFIG_SMP))
-1:	ldstub		[%g1 + 4], %g7
-#else
-1:	set		4, %g7
-	ldstuba		[%g1 + %g7] 1, %g7 /* ASI_LEON23_DCACHE_MISS */
-#endif
-	tst		%g7
-	bne		1b
-	 ld		[%g1], %g7
-	add		%g7, %g2, %g7
-	st		%g7, [%g1]
-	stb		%g0, [%g1 + 4]
-#else
-	ld		[%g1], %g7
-	add		%g7, %g2, %g7
-	st		%g7, [%g1]
-#endif
-	wr		%g3, 0, %psr
-	sub		%g7, %g2, %g7
-	nop
-	nop
-	addcc		%g7, %g2, %g7
-	bcs		3f
-	 nop
-2:	jmpl		%o7, %g0
-	 mov		%g4, %o7
-3:	save		%sp, -64, %sp
-	mov		%g1, %l1
-	mov		%g4, %l4
-	mov		%g5, %l5
-	mov		%g7, %o1
-	call		__rwsem_wake
-	 mov		%l1, %o0
-	mov		%l1, %g1
-	mov		%l4, %g4
-	ba		2b
-	 restore	%l5, %g0, %g5
-- 
1.5.4

