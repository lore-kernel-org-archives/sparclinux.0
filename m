From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 08 Apr 2004 12:25:17 +0000
Subject: 2.6.5-mc2 switch_to() fix
Message-Id: <20040408122517.GD688@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I needed the following fix to boot. There were -Werror issues in the
32-bit exec() emulation code too, but those should probably be attacked
some other way besides removing -Werror (which is what I did).

This patch changes bne,pn to branch to a newly-introduced unconditional
branch, which may accept larger relocations than the conditional branch.
The branch delay slot of the converted conditional branch remains
intact, preserving the semantics where mov %g5, %0 is done
unconditionally. The annul bit is also set on the unconditional branch,
which prevents the execution of any instruction that may occur in its
branch delay slot from ever happening, rendering its position at the
end of the assembly fragment safe.

With this patch in place an Ultra2 and E3000 were able to boot and run
userspace on otherwise unadulterated 2.6.5-mc2 where they were not able
to do so without the patch. I'm not terribly familiar with SPARC
assembly (though I've dabbled in it before) so hopefully the above is
sufficiently coherent and/or at least shows I tried to do my homework.


-- wli


Index: hugetlb-2.6.5-1/include/asm-sparc64/system.h
=================================--- hugetlb-2.6.5-1.orig/include/asm-sparc64/system.h	2004-04-03 19:36:14.000000000 -0800
+++ hugetlb-2.6.5-1/include/asm-sparc64/system.h	2004-04-08 04:42:47.000000000 -0700
@@ -205,8 +205,10 @@
 	"ldx	[%%g6 + %7], %%g4\n\t"					\
 	"wrpr	%%g0, 0x96, %%pstate\n\t"				\
 	"andcc	%%o7, %6, %%g0\n\t"					\
-	"bne,pn	%%icc, ret_from_syscall\n\t"				\
+	"beq,pn %%icc, 1f\n\t"						\
 	" mov	%%g5, %0\n\t"						\
+	"b,a ret_from_syscall\n\t"					\
+	"1:\n\t"							\
 	: "=&r" (last)							\
 	: "0" (next->thread_info),					\
 	  "i" (TI_WSTATE), "i" (TI_KSP), "i" (TI_FLAGS), "i" (TI_CWP),	\
