From: David Miller <davem@davemloft.net>
Date: Fri, 27 May 2016 19:37:31 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <20160527.123731.2105286005500436503.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87fut34unx.fsf@esperi.org.uk>
	<87fut34unx.fsf@esperi.org.uk>
	<87twhj3ag0.fsf@esperi.org.uk>
In-Reply-To: <87twhj3ag0.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nix@esperi.org.uk
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

From: Nick Alcock <nix@esperi.org.uk>
Date: Fri, 27 May 2016 14:19:27 +0100

> The only difference between the two series above is that in the crashing
> series, the ka_restorer stub functions __rt_sigreturn_stub and
> __sigreturn_stub (on sparc32) and __rt_sigreturn_stub (on sparc64) get
> stack-protected; in the non-crashing series, they do not; the same is
> true without --enable-stack-protector=all, because the functions have no
> local variables at all, so without -fstack-protector-all they don't get
> stack-protected in any case. Passing such a stack-protected function in
> as the ka_restorer stub seems to suffice to cause this crash at some
> later date. I'm wondering if the stack canary is clobbering something
> that the caller does not expect to be clobbered: we saw this cause
> trouble on x86 in a different context (see upstream commit
> 7a25d6a84df9fea56963569ceccaaf7c2a88f161).

This is amazing that it makes a difference since the sigreturn stub is
implemented entirely in inline assembler :-)

Normally the 64-bit stub is emitted as:

__rt_sigreturn_stub:
        mov 101, %g1
        ta 0x6d

and with -fstack-protector-all we get:

__rt_sigreturn_stub:
        save    %sp, -192, %sp
        ldx     [%g7+40], %g1
        stx     %g1, [%fp+2039]
        mov     0, %g1

        mov 101, %g1
        ta 0x6d

        ldx     [%fp+2039], %g1
        ldx     [%g7+40], %g2
        xor     %g1, %g2, %g1
        mov     0, %g2
        brnz,pn %g1, .LL4
         nop
        return  %i7+8
         nop
.LL4:
        call    __stack_chk_fail, 0
         nop
        nop

That 'save' is the problem.

One can't change the register window or the stack pointer in this
function, as the kernel has setup the restore frame at a precise
location relative to the stack pointer when the stub is invoked.

Basically, do_rt_sigreturn is restoring garbage into the cpu
registers.

It obviously shouldn't crash, which I'll look into, but it is clear
that we can't enable -fstack-protector-all for this function.

So far I'm playing with the patch below to do some basic sanity
checks on the values inside of the sigreturn frame:

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 3c25241..6eb39a7 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -138,6 +138,18 @@ int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
 	return 0;
 }
 
+/* Checks if the fp is valid.  We always build signal frames which are
+ * 16-byte aligned, therefore we can always enforce that the restore
+ * frame has that property as well.
+ */
+static bool invalid_frame_pointer(void __user *fp, int fplen)
+{
+	if ((((unsigned long) fp) & 15) ||
+	    ((unsigned long)fp) > 0x100000000ULL - fplen)
+		return true;
+	return false;
+}
+
 void do_sigreturn32(struct pt_regs *regs)
 {
 	struct signal_frame32 __user *sf;
@@ -158,8 +170,10 @@ void do_sigreturn32(struct pt_regs *regs)
 	sf = (struct signal_frame32 __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
-	    (((unsigned long) sf) & 3))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
+		goto segv;
+
+	if (sf->info.si_regs.u_regs[UREG_FP] & 3)
 		goto segv;
 
 	if (get_user(pc, &sf->info.si_regs.pc) ||
@@ -242,8 +256,10 @@ asmlinkage void do_rt_sigreturn32(struct pt_regs *regs)
 	sf = (struct rt_signal_frame32 __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
-	    (((unsigned long) sf) & 3))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
+		goto segv;
+
+	if (sf->regs.u_regs[UREG_FP] & 3)
 		goto segv;
 
 	if (get_user(pc, &sf->regs.pc) || 
@@ -307,14 +323,6 @@ segv:
 	force_sig(SIGSEGV, current);
 }
 
-/* Checks if the fp is valid */
-static int invalid_frame_pointer(void __user *fp, int fplen)
-{
-	if ((((unsigned long) fp) & 7) || ((unsigned long)fp) > 0x100000000ULL - fplen)
-		return 1;
-	return 0;
-}
-
 static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
 {
 	unsigned long sp;
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 39aaec1..a8f0019 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -234,6 +234,17 @@ do_sigsegv:
 	goto out;
 }
 
+/* Checks if the fp is valid.  We always build rt signal frames which
+ * are 16-byte aligned, therefore we can always enforce that the
+ * restore frame has that property as well.
+ */
+static bool invalid_frame_pointer(void __user *fp)
+{
+	if (((unsigned long) fp) & 15)
+		return true;
+	return false;
+}
+
 struct rt_signal_frame {
 	struct sparc_stackf	ss;
 	siginfo_t		info;
@@ -261,7 +272,10 @@ void do_rt_sigreturn(struct pt_regs *regs)
 		(regs->u_regs [UREG_FP] + STACK_BIAS);
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (((unsigned long) sf) & 3)
+	if (invalid_frame_pointer(sf))
+		goto segv;
+
+	if ((sf->regs.u_regs[UREG_FP] + STACK_BIAS) & 7)
 		goto segv;
 
 	err = get_user(tpc, &sf->regs.tpc);
@@ -308,14 +322,6 @@ segv:
 	force_sig(SIGSEGV, current);
 }
 
-/* Checks if the fp is valid */
-static int invalid_frame_pointer(void __user *fp)
-{
-	if (((unsigned long) fp) & 15)
-		return 1;
-	return 0;
-}
-
 static inline void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs, unsigned long framesize)
 {
 	unsigned long sp = regs->u_regs[UREG_FP] + STACK_BIAS;
