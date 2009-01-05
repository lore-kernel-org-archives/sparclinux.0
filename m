From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jan 2009 07:20:41 +0000
Subject: Re: Export reg.h to userspace
Message-Id: <20090104.232041.224044383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090103123341.GB18259@uranus.ravnborg.org>
In-Reply-To: <20090103123341.GB18259@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 13:13:17 -0800 (PST)

> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 3 Jan 2009 13:33:41 +0100
> 
> > I did not check glibc/gdb if they use ths file - I did
> > not feel brave enough to dive into these as it is new
> > territory for me.
> 
> GDB used to, a long long time ago, but that didn't turn
> out to be tenable so gdb does things by hand these days
> to get the ptrace layouts it wants to grok.
> 
> There might be some stray userland references still, I'll
> try to do some research on this.

Ok, I did some checking, nothing uses this stuff.

I've killed it off as follows:

sparc: Kill asm/reg*.h

As noticed by Sam Ravnborg, these aren't use for anything.
Neither the kernel nor userland make a reference to this
family of header files.

So just get rid of them.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/reg.h    |    8 ----
 arch/sparc/include/asm/reg_32.h |   79 ---------------------------------------
 arch/sparc/include/asm/reg_64.h |   56 ---------------------------
 3 files changed, 0 insertions(+), 143 deletions(-)
 delete mode 100644 arch/sparc/include/asm/reg.h
 delete mode 100644 arch/sparc/include/asm/reg_32.h
 delete mode 100644 arch/sparc/include/asm/reg_64.h

diff --git a/arch/sparc/include/asm/reg.h b/arch/sparc/include/asm/reg.h
deleted file mode 100644
index 0c16e19..0000000
--- a/arch/sparc/include/asm/reg.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef ___ASM_SPARC_REG_H
-#define ___ASM_SPARC_REG_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/reg_64.h>
-#else
-#include <asm/reg_32.h>
-#endif
-#endif
diff --git a/arch/sparc/include/asm/reg_32.h b/arch/sparc/include/asm/reg_32.h
deleted file mode 100644
index 1efb056..0000000
--- a/arch/sparc/include/asm/reg_32.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * linux/include/asm/reg.h
- * Layout of the registers as expected by gdb on the Sparc
- * we should replace the user.h definitions with those in
- * this file, we don't even use the other
- * -miguel
- *
- * The names of the structures, constants and aliases in this file
- * have the same names as the sunos ones, some programs rely on these
- * names (gdb for example).
- *
- */
-
-#ifndef __SPARC_REG_H
-#define __SPARC_REG_H
-
-struct regs {
-	int     r_psr;
-#define r_ps r_psr
-        int     r_pc;
-        int     r_npc;
-        int     r_y;
-        int     r_g1;
-        int     r_g2;
-        int     r_g3;
-        int     r_g4;
-        int     r_g5;
-        int     r_g6;
-        int     r_g7;
-        int     r_o0;
-        int     r_o1;
-        int     r_o2;
-        int     r_o3;
-        int     r_o4;
-        int     r_o5;
-        int     r_o6;
-        int     r_o7;
-};
-
-struct fpq {
-        unsigned long *addr;
-        unsigned long instr;
-};
-
-struct  fq {
-        union {
-                double  whole;
-                struct  fpq fpq;
-        } FQu;
-};
-
-#define FPU_REGS_TYPE unsigned int
-#define FPU_FSR_TYPE unsigned
-
-struct fp_status {
-        union {
-                FPU_REGS_TYPE Fpu_regs[32];
-                double  Fpu_dregs[16];
-        } fpu_fr;
-        FPU_FSR_TYPE Fpu_fsr;
-        unsigned Fpu_flags;
-        unsigned Fpu_extra;
-        unsigned Fpu_qcnt;
-        struct fq Fpu_q[16];
-};
-
-#define fpu_regs  f_fpstatus.fpu_fr.Fpu_regs
-#define fpu_dregs f_fpstatus.fpu_fr.Fpu_dregs
-#define fpu_fsr   f_fpstatus.Fpu_fsr
-#define fpu_flags f_fpstatus.Fpu_flags
-#define fpu_extra f_fpstatus.Fpu_extra
-#define fpu_q     f_fpstatus.Fpu_q
-#define fpu_qcnt  f_fpstatus.Fpu_qcnt
-
-struct fpu {
-        struct fp_status f_fpstatus;
-};
-
-#endif /* __SPARC_REG_H */
diff --git a/arch/sparc/include/asm/reg_64.h b/arch/sparc/include/asm/reg_64.h
deleted file mode 100644
index 6f277d7..0000000
--- a/arch/sparc/include/asm/reg_64.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * linux/asm/reg.h
- * Layout of the registers as expected by gdb on the Sparc
- * we should replace the user.h definitions with those in
- * this file, we don't even use the other
- * -miguel
- *
- * The names of the structures, constants and aliases in this file
- * have the same names as the sunos ones, some programs rely on these
- * names (gdb for example).
- *
- */
-
-#ifndef __SPARC64_REG_H
-#define __SPARC64_REG_H
-
-struct regs {
-        unsigned long r_g1;
-        unsigned long r_g2;
-        unsigned long r_g3;
-        unsigned long r_g4;
-        unsigned long r_g5;
-        unsigned long r_g6;
-        unsigned long r_g7;
-        unsigned long r_o0;
-        unsigned long r_o1;
-        unsigned long r_o2;
-        unsigned long r_o3;
-        unsigned long r_o4;
-        unsigned long r_o5;
-        unsigned long r_o6;
-        unsigned long r_o7;
-        unsigned long __pad;
-        unsigned long r_tstate;
-        unsigned long r_tpc;
-        unsigned long r_tnpc;
-        unsigned int  r_y;
-        unsigned int  r_fprs;
-};
-
-#define FPU_REGS_TYPE unsigned int
-#define FPU_FSR_TYPE unsigned long
-
-struct fp_status {
-        unsigned long fpu_fr[32];
-        unsigned long Fpu_fsr;
-};
-
-struct fpu {
-	struct fp_status f_fpstatus;
-};
-
-#define fpu_regs  f_fpstatus.fpu_fr
-#define fpu_fsr   f_fpstatus.Fpu_fsr
-
-#endif /* __SPARC64_REG_H */
-- 
1.6.1.15.g159c88

