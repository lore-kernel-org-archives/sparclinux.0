Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836D299929;
	Sun, 27 Sep 2026 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470767; cv=none; b=X/4ty6pc+xQ815SOQ9/PvUHDzo/ku9iy05q40FBmUkpCJzi+AdA6j+TRAdN4j/OUG9fIBkZtNZfwdQHKI+2h3AJRU90+Tb+EuOku4f86lPn3CsV8raQ353ECGL9KSV5POFq46v2Q9driQ1RjgaC4Ge64eYHqY8fUNangr8ur9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470767; c=relaxed/simple;
	bh=aNDhxoHomqUQlzyj18kZHSlLKwyQfCpC3CLSzM1P5ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNJ4/Ch7t2smW+CXf0CeoFuYKdPGy2Y74/dl6MRFpw/GgnioI0NBY/it6pLxXkPMN8BLLxP+VkoBeGSHrlNAfMEFfhVVlg26/5JR5XxJIv2tM3sr8hOqth7N/9/2Iyw33p3rRufY5K3BIAg8wjRJoRdP63BX8dY587zuc8VbN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCoC7C8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCoC7C8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757FE1F00893;
	Sun, 27 Sep 2026 00:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470765;
	bh=wjVbXeOox9D4U8TChVgCNfuB6AebwcGSxhEp8VBms4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lCoC7C8fZay3syzFr4AeWsT2Q6cxgXZqQj8FoymQewZ/cJXbeW8WFfeeSHaTpyZFJ
	 Utum9YiTHLnhqnznMmqrakyGJhKMjCE33n+LeT9rlQHHU2KqfWmPCohNvxQwPokQOd
	 Kn5GKJfa01tNIqcMsqKQpg3Udj9mYOHUzdVGQ2tnlpGeAnB0gDuIX8c4REpWHwmmfE
	 5v6rHLt575n/u9/FEO5nv0xDZmyCU8fpKZiizSxtW8804q//E08phMEAog5CLC9gtT
	 WeSd7ks7HuP4lymvqHo75FFwFpSCFTUYGXCBc8/2dsPWUM1EEfVoxWVfk63Z3T2+NE
	 PVUREznISxAWw==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 1/3] sparc32: support futexes on SMP
Date: Sun, 27 Sep 2026 02:58:19 +0200
Message-ID: <20260927005821.8369-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927005821.8369-1-kaloz@kernel.org>
References: <20260927005821.8369-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asm-generic/futex.h provides the futex atomic ops for UP only, so FUTEX
has depended on !(SPARC32 && SMP).

Implement them in atomic32.c for both. LEON parts that implement casa
run it on the user word, as user code updates the word with casa there
and takes no kernel lock. Other CPUs have no compare-and-swap; the ops
serialize on __atomic_hash, which lets a kernel emulation of user casa
share the lock.

casa is optional on LEON, so it is probed once at boot. On a part
without it the kernel-mode illegal_instruction is fixed up from the
exception table.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/include/asm/futex_32.h |   6 +-
 arch/sparc/kernel/traps_32.c      |  13 +++-
 arch/sparc/lib/atomic32.c         | 122 ++++++++++++++++++++++++++++++
 init/Kconfig                      |   1 -
 4 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/futex_32.h b/arch/sparc/include/asm/futex_32.h
index 6a332a9f099c..2271aad566f8 100644
--- a/arch/sparc/include/asm/futex_32.h
+++ b/arch/sparc/include/asm/futex_32.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#include <asm-generic/futex.h>
+#include <linux/types.h>
+
+int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
+int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+				  u32 oldval, u32 newval);
 
 #endif
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index bb149f6cc34b..e1d50820c376 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/extable.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/debug.h>
 #include <linux/mm_types.h>
@@ -108,8 +109,18 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
-	if(psr & PSR_PS)
+	if (psr & PSR_PS) {
+		const struct exception_table_entry *entry;
+
+		/* The casa probe on a CPU without casa. */
+		entry = search_exception_tables(pc);
+		if (entry) {
+			regs->pc = entry->fixup;
+			regs->npc = regs->pc + 4;
+			return;
+		}
 		die_if_kernel("Kernel illegal instruction", regs);
+	}
 #ifdef TRAP_DEBUG
 	printk("Ill instr. at pc=%08lx instruction is %08lx\n",
 	       regs->pc, *(unsigned long *)regs->pc);
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 8ae880ebf07a..be712c2917d5 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -9,8 +9,13 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/futex.h>
+#include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/uaccess.h>
+#include <asm/cpu_type.h>
+#include <asm/futex.h>
 
 #ifdef CONFIG_SMP
 #define ATOMIC_HASH_SIZE	4
@@ -195,3 +200,120 @@ unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
 	return (unsigned long)prev;
 }
 EXPORT_SYMBOL(__xchg_u32);
+
+/* Only some LEON parts implement casa. */
+static bool sparc32_casa __ro_after_init;
+
+static int __casa_user(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newval)
+{
+	/*
+	 * casa [%o0] 0xb, %o1, %o2, as a word any assembler accepts. ASI
+	 * 0x0b is the supervisor address space; the emulated casa in
+	 * cas_emu_32.c instead accepts the user ASIs 0x0a and 0x80.
+	 */
+	register u32 __user *uaddr_r asm("o0") = uaddr;
+	register u32 oldval_r asm("o1") = oldval;
+	register u32 newval_r asm("o2") = newval;
+	int ret = 0;
+
+	__asm__ __volatile__(
+	"1:	.word	0xd5e20169\n"
+	"2:\n"
+	"	.section .fixup,#alloc,#execinstr\n"
+	"	.align	4\n"
+	"3:	sethi	%%hi(2b), %0\n"
+	"	jmpl	%0 + %%lo(2b), %%g0\n"
+	"	 mov	%4, %0\n"
+	"	.previous\n"
+	"	.section __ex_table,#alloc\n"
+	"	.align	4\n"
+	"	.word	1b, 3b\n"
+	"	.previous\n"
+	: "+r" (ret), "+r" (newval_r)
+	: "r" (uaddr_r), "r" (oldval_r), "i" (-EFAULT)
+	: "memory");
+
+	*uval = newval_r;
+	return ret;
+}
+
+/* Without casa the illegal_instruction trap takes the fixup above. */
+static int __init sparc32_casa_probe(void)
+{
+	u32 word = 0, val;
+
+	if (sparc_cpu_model == sparc_leon)
+		sparc32_casa = !__casa_user(&val, (u32 __force __user *)&word,
+					    0, 1);
+	return 0;
+}
+early_initcall(sparc32_casa_probe);
+
+/*
+ * Without casa, user CAS is emulated under the same lock. ATOMIC_HASH()
+ * uses page offset bits only, so every mapping of a word takes one lock.
+ */
+int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+				  u32 oldval, u32 newval)
+{
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+	if (sparc32_casa)
+		return __casa_user(uval, uaddr, oldval, newval);
+
+	/* Every caller already runs with page faults disabled. */
+	spin_lock_irqsave(ATOMIC_HASH(uaddr), flags);
+	ret = __get_user(val, uaddr);
+	if (!ret && val == oldval)
+		ret = __put_user(newval, uaddr);
+	spin_unlock_irqrestore(ATOMIC_HASH(uaddr), flags);
+
+	if (!ret)
+		*uval = val;
+	return ret;
+}
+
+int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+{
+	u32 oldval, newval, val;
+	int ret;
+
+	if (get_user(oldval, uaddr))
+		return -EFAULT;
+
+	for (;;) {
+		switch (op) {
+		case FUTEX_OP_SET:
+			newval = oparg;
+			break;
+		case FUTEX_OP_ADD:
+			newval = oldval + oparg;
+			break;
+		case FUTEX_OP_OR:
+			newval = oldval | oparg;
+			break;
+		case FUTEX_OP_ANDN:
+			newval = oldval & ~oparg;
+			break;
+		case FUTEX_OP_XOR:
+			newval = oldval ^ oparg;
+			break;
+		default:
+			return -ENOSYS;
+		}
+
+		ret = futex_atomic_cmpxchg_inatomic(&val, uaddr, oldval, newval);
+		if (ret)
+			return ret;
+		if (val == oldval)
+			break;
+		oldval = val;
+	}
+
+	*oval = oldval;
+	return 0;
+}
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..9eb8086af7db 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1875,7 +1875,6 @@ config BASE_SMALL
 
 config FUTEX
 	bool "Enable futex support" if EXPERT
-	depends on !(SPARC32 && SMP)
 	default y
 	imply RT_MUTEXES
 	help
-- 
2.47.3

