Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158F3A6F1C;
	Wed,  2 Sep 2026 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334104; cv=none; b=oCycS4elGBo9TET+t2xkOF7G1ReLs8ItGArWG0E0rfqXW/jl+cqQKtQBR2/hQcqIjs6Ib6Vd6pXkbIriLZK7lnDnTk+4y8GMe+ETXH+IvDfn2wCHLMlNCubo8L4l7EC4+G5eACZLzPS8P4Osc8S4yOn6xmODSjM83AmEOnsS78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334104; c=relaxed/simple;
	bh=HF/nsXgvIgE/DqWSyjb6qWME6Vld3OUbinIXCPVsq1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSEVQ96Z2SJSUGhPGPVZnsCzUtXSFDPRvlEjETCNh4lA/O6H8FR5FRpZugHA2g3uGF+LIelVxJAX44yeENNlWwT8gMl+IpqIlyfoIYqilSXcER6ExFUn7uw/IdUouK/SvSeT32C8l9tY4dXRH92/mjXB25NPHmbHnswS2THZuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=AZuunSQG; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="AZuunSQG"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788334100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KWRCPVDC04wzldr1gUDv05InG5kUt+e/FIgG4quucis=;
	b=AZuunSQGyOIct3j3TUk3nJ/AQqPNUxoW4A3DPj7cAluZGF7NxZ9dJ8a1OteMrWihxRcC7p
	u5C6OHJIs7mbBhYe/L8OsrkGdLHnCNWJ1lFLwTEdFj+x9i7eByqRa7L2v6E9KQwfHjnAj7
	IEk+7JTk9L0yHHhskS1jySxRZbyHY+I=
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
Subject: [PATCH v2 0/2] sparc64: add seccomp filter support
Date: Wed,  2 Sep 2026 09:27:43 +0200
Message-ID: <20260902072745.3412940-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds SECCOMP_FILTER support for sparc64.

The arch prerequisites have been in place for years, so patch 1 is
mostly about the missing piece: letting seccomp veto a syscall, and
returning to user space with the return value the seccomp core set in
pt_regs rather than the -ENOSYS the assembler stubs used to force on
any denied syscall.  Patch 2 teaches the seccomp_bpf selftest to
drive sparc64's registers.

Tested on an UltraSPARC T4-1 (sun4v):

  - tools/testing/selftests/seccomp/seccomp_bpf: 95 passed, 0 failed,
    16 skipped (uprobes and other optional features)
  - libseccomp with its pending SPARC support (libseccomp PR #471)
    passes its full suite, 5190 of 5190, including the live tests
    that require kernel SECCOMP_FILTER
  - docker containers run confined by the default profile, and a
    custom SCMP_ACT_ERRNO profile denies as expected

The libseccomp side is https://github.com/seccomp/libseccomp/pull/471,
and the tracking issue is https://github.com/sparclinux/issues/issues/11.

v2: drop the local regs-struct definition in the selftest in favour of
    PTRACE_GETREGS64/PTRACE_SETREGS64 and the uapi struct pt_regs
    (Kees Cook); patch 1 unchanged.

Stian Halseth (2):
  sparc64: add seccomp filter support
  selftests/seccomp: add sparc64 support

 arch/sparc/Kconfig                            |  2 +-
 arch/sparc/include/asm/seccomp.h              | 15 ++++++++
 arch/sparc/include/asm/syscall.h              | 11 +++---
 arch/sparc/kernel/entry.h                     |  2 +-
 arch/sparc/kernel/ptrace_64.c                 | 28 ++++++++++-----
 arch/sparc/kernel/syscalls.S                  | 28 +++++++++++----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 36 ++++++++++++++++++++
 7 files changed, 99 insertions(+), 23 deletions(-)

-- 
2.45
