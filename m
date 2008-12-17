From: David Miller <davem@davemloft.net>
Date: Wed, 17 Dec 2008 05:41:00 +0000
Subject: Re: random dumb (or maybe not) question about sparc64
Message-Id: <20081216.214100.07002773.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812091146.mB9Bkqn02109@elf.torek.net>
In-Reply-To: <200812091146.mB9Bkqn02109@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2008 04:12:15 -0800 (PST)

> From: Chris Torek <chris.torek@windriver.com>
> Date: Tue, 09 Dec 2008 04:46:52 -0700
> 
> > The ptrace code uses flushw_user() to push user windows ... good
> > enough, except, a bunch of other code then also does
> > synchronize_user_stack(), but ptrace does not.
 ...
> Perhaps the best place would be in the arch_ptrace_stop() hook.
> I believe IA64 uses this for the register backing store on that
> cpu.  It seems to be created exactly for the case we are discussing
> here. :)
> 
> What do you think?

I guess Chris is not excited enough about this issue to
reply :-)

Anyways, here is the fix I'll probably push upstream.
32-bit sparc will need something similar and I'll implement
that too.

Thanks for the report:

diff --git a/arch/sparc/include/asm/ptrace_64.h b/arch/sparc/include/asm/ptrace_64.h
index 84e969f..cd6fbfc 100644
--- a/arch/sparc/include/asm/ptrace_64.h
+++ b/arch/sparc/include/asm/ptrace_64.h
@@ -114,6 +114,7 @@ struct sparc_trapf {
 #ifdef __KERNEL__
 
 #include <linux/threads.h>
+#include <asm/system.h>
 
 static inline int pt_regs_trap_type(struct pt_regs *regs)
 {
@@ -130,6 +131,14 @@ static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
 	return (regs->tstate &= ~TSTATE_SYSCALL);
 }
 
+#define arch_ptrace_stop_needed(exit_code, info) \
+({	flush_user_windows(); \
+	get_thread_wsaved() != 0; \
+})
+
+#define arch_ptrace_stop(exit_code, info) \
+	synchronize_user_stack()
+
 struct global_reg_snapshot {
 	unsigned long		tstate;
 	unsigned long		tpc;
