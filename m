Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4285472F6A;
	Tue,  1 Sep 2026 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300524; cv=none; b=Fa7ZSSDridGtNAZupI7FSkuJbb4eXm91ww8NJLWDOMpJaiFyitXN5rkEvdgXyDnjEjMMxLabecbhtZiVVhPlvAUrbXcxSybLOd/IaCqU1V4HlEFYHRvcMUt4WzNgFnphqI0FWlFZCmHeIPkRGvGIjyD/7pIbq5As3F3mA9W6y1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300524; c=relaxed/simple;
	bh=8xRfhH0Undl1k3VO7cD/AQEoOf2pwXiAqpaFcHKaExQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBjvSglwfKcPfQcByp/4d+tx0ZRGPNswnuVGE4iDhaxOT+/PDVWC1pXKEEoYZ0ghrkMiDT4+kmIfOGOYGFD0pQg02zQ2vJY/8lLGDkguvlWgDY7lCf/hfxiTK20Ue0dDB3MLZaTYHia9y7G2c+d2cd2BvzY5aXU36J+E9AwG0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Xq8vSKQv; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Xq8vSKQv"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788300518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QHyaGIfCuznKOL3ZeqhIzWsbnLjc7ISrhbuAi5RuaWs=;
	b=Xq8vSKQvuqodmTOC89fX00p4n5jWZpRdHO9H7qJRSeK907EmcXCsXTZ6yPRxVs65R06RcW
	JGa/fDcundo/vVqObEsEob/1dpPNlLJVQawXkQzJPnGEUQ1qDiyWDiBvf8WxuM8LRenJDi
	sr2ogHZo3Kg86Od7yHBvqk/cYxTHf8Y=
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
Subject: [PATCH 2/2] selftests/seccomp: add sparc64 support
Date: Wed,  2 Sep 2026 00:08:11 +0200
Message-ID: <20260901220811.3369666-3-stian@itx.no>
In-Reply-To: <20260901220811.3369666-1-stian@itx.no>
References: <20260901220811.3369666-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparc64 now selects HAVE_ARCH_SECCOMP_FILTER, so teach seccomp_bpf
how to read and write its registers: the syscall number lives in %g1
and the return value in %o0, addressed through the NT_PRSTATUS regset
(16 u_regs, 16 window registers, then tstate/tpc/tnpc/y).

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
 tools/testing/selftests/seccomp/seccomp_bpf.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 0622bc2acad4..30b777f357d8 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1872,6 +1872,41 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS		struct user_regs_struct
 # define SYSCALL_NUM(_regs)	(_regs).orig_d0
 # define SYSCALL_RET(_regs)	(_regs).d0
+#elif defined(__sparc__) && defined(__arch64__)
+/*
+ * The NT_PRSTATUS regset: %g0-%g7 and %o0-%o7, the 16 window
+ * registers as read back from the stack, then tstate, tpc, tnpc
+ * and y.
+ */
+struct sparc64_user_regs {
+	__u64 u_regs[16];
+	__u64 window[16];
+	__u64 tstate;
+	__u64 tpc;
+	__u64 tnpc;
+	__u64 y;
+};
+# define ARCH_REGS		struct sparc64_user_regs
+# define SYSCALL_NUM(_regs)	(_regs).u_regs[1]	/* %g1 */
+# define SYSCALL_RET(_regs)	(_regs).u_regs[8]	/* %o0 */
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
-- 
2.43.0

