Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293F3D0939;
	Wed,  2 Sep 2026 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334113; cv=none; b=BG+op2l6+GXs2St6keEzXGmWeaZ4wlLydqs8hD1YaN0eut6y1WTXAmMFisRqtfk8C6eqcmDcJUUPFV+ZzwK/O9CGhbuPKKzGa3j2ywH1AtesOT8Bpvwm1U5iQcmZimbbf77HFpxoQaSvd/5MXSOq9vPrn7zaDIINBEUGfhTgzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334113; c=relaxed/simple;
	bh=32XgzvgcAvOMeWmCxaUc4eTUndOQ98uP3VUdLdUDvcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHEG+qwS/uQTWRNsLPdPOO8ySjRowscnBv3eUno9KBdE29yCkAU1lGbgfG4Yw2X0HqqawS/3VrISC7DreDm8k4CWZSzsBk5dtqmVL4xjoGkXBdINUiFfVEhOUQEE/zFXVvZLZCA7K89DweK7dWKjWk8iep+D0lZAAXo4HzkJdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=EeaRCk0r; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="EeaRCk0r"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788334109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AowIdWVlih1ZdZxEW4QviidjDC/yIXmYnu0qnAul1C4=;
	b=EeaRCk0rMWlKVIVxJ1hVDK3WbpiDpizmuMw0cCfCknxZtdtDW+Xmg0a7T+vnLBIutCOtUS
	ABG+Tggz7dutzfYA0/7x1NOmP+LmQcJRsT91623xuPgXor8azAMsa2F7OfPO3n2RmpsIkY
	A1lNsmNECrNa7KRTmmDj79Ebzu0knlk=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 2/2] selftests/seccomp: add sparc64 support
Date: Wed,  2 Sep 2026 09:27:45 +0200
Message-ID: <20260902072745.3412940-3-stian@itx.no>
In-Reply-To: <20260902072745.3412940-1-stian@itx.no>
References: <20260902072745.3412940-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparc64 now selects HAVE_ARCH_SECCOMP_FILTER, so teach seccomp_bpf
how to read and write its registers: the syscall number lives in %g1
and the return value in %o0.  The NT_PRSTATUS regset appends the
register window read back from the tracee's stack and has no exported
layout, so use the sparc-specific PTRACE_GETREGS64/PTRACE_SETREGS64
requests instead, which transfer the uapi struct pt_regs directly.

Errors are signaled by the carry bit in tstate with a positive errno
value in %o0, so provide a SYSCALL_RET_SET that maintains both, and
mark the arch SYSCALL_RET_SET_ON_PTRACE_EXIT since a return value
poked at entry would be overwritten by the syscall skip path, as on
powerpc.

Passes 95 of 95 on an UltraSPARC T4-1 (16 skipped for missing
optional features such as uprobes).

Link: https://github.com/sparclinux/issues/issues/11
Signed-off-by: Stian Halseth <stian@itx.no>
---
v2: use PTRACE_GETREGS64/PTRACE_SETREGS64 and the uapi struct pt_regs
    instead of a locally defined NT_PRSTATUS regset layout, as
    suggested by Kees Cook. Note the historical %g0 omission in that
    layout, which shifts the u_regs indices by one.

 tools/testing/selftests/seccomp/seccomp_bpf.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 0622bc2acad4..3711060c22a7 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1872,6 +1872,34 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS		struct user_regs_struct
 # define SYSCALL_NUM(_regs)	(_regs).orig_d0
 # define SYSCALL_RET(_regs)	(_regs).d0
+#elif defined(__sparc__) && defined(__arch64__)
+# include <asm/ptrace.h>
+/*
+ * PTRACE_GETREGS64/PTRACE_SETREGS64 transfer the uapi struct pt_regs,
+ * but in the historical layout that omits %g0: the blob starts at %g1,
+ * so every u_regs index is one lower than the register number suggests.
+ */
+# define ARCH_REGS		struct pt_regs
+# define SYSCALL_NUM(_regs)	(_regs).u_regs[0]	/* %g1 */
+# define SYSCALL_RET(_regs)	(_regs).u_regs[7]	/* %o0 */
+/*
+ * A syscall error is signaled by the carry bit in tstate, with the
+ * errno held in %o0 as a positive value; the carry can only be
+ * written reliably once the syscall has been skipped or has run.
+ */
+# define SPARC64_TSTATE_CARRY	0x0000001100000000UL	/* xcc.c | icc.c */
+# define SYSCALL_RET_SET(_regs, _val)				\
+	do {							\
+		typeof(_val) _result = (_val);			\
+		if (_result < 0) {				\
+			SYSCALL_RET(_regs) = -_result;		\
+			(_regs).tstate |= SPARC64_TSTATE_CARRY;	\
+		} else {					\
+			SYSCALL_RET(_regs) = _result;		\
+			(_regs).tstate &= ~SPARC64_TSTATE_CARRY; \
+		}						\
+	} while (0)
+# define SYSCALL_RET_SET_ON_PTRACE_EXIT
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
@@ -1939,6 +1967,14 @@ const bool ptrace_entry_set_syscall_ret =
 #if defined(__x86_64__) || defined(__i386__) || defined(__mips__) || defined(__mc68000__)
 # define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS, tracee, 0, &(_regs))
 # define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS, tracee, 0, &(_regs))
+#elif defined(__sparc__) && defined(__arch64__)
+/*
+ * The NT_PRSTATUS regset appends the register window, which struct
+ * pt_regs does not carry; the sparc-specific requests transfer
+ * struct pt_regs directly (and take the buffer in addr).
+ */
+# define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS64, tracee, &(_regs), 0)
+# define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS64, tracee, &(_regs), 0)
 #else
 # define ARCH_GETREGS(_regs)	({					\
 		struct iovec __v;					\
-- 
2.43.0

