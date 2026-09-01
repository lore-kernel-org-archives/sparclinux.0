Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDD43F4B5;
	Tue,  1 Sep 2026 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300515; cv=none; b=K6bBW/1l0W2GuY1cJ/tzPyU+tbdkdRtQXYLrhu74/rMzJ18qiFmfJ7guFrSjeXTFW4ZK2/BfgtOkYsPY4/U9n2Jm38/BpmRPDzwG1R4NVJDQEnQXH4mwyhFcnG9L1sC4bzcJ2Q46cywwVxZodH4q5cmdC5qEQ+PCD7N4xBqOymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300515; c=relaxed/simple;
	bh=PZCh8+4LJ906fIrDSP915VFyemAeG3uWlTzWYUuEHIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqLHu/4d7T274qTDirlb1dUSrgW16XrA3XimGgeJU1vpxgmXVeZxv2UQoiLstYfPkJ4cb4n2w5lUvsqzgC9PHv65hujpNXTmW89YrvzNWmYRvxKsIxx0K5+wbbIHUq2LZw5Z/dtA6JXT9FqxnlUomp7iDCZPmipq/cBSJDIcmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=kOLYQgAh; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="kOLYQgAh"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788300509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L5ItQBcdK1U2y12RotRrhXkN+PYLyvKp8+bgoCWE4Kg=;
	b=kOLYQgAhUNXgCMcGDM4wOJQOTp+YDt/MwL82HrTyBo/fuAOrG0fuer6eNAsPgMJVxQ0y5d
	MxPkCBTdUqPDnOtolmwWMI/53Pu9gg1fNJxMm5pGUgCP8oYRuOeKKr55Wyw5t2BulpqevL
	b5vdQEMKNcvBeaKrro8Z0K5rsrFE+bk=
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
Subject: [PATCH 0/2] sparc64: add seccomp filter support
Date: Wed,  2 Sep 2026 00:08:09 +0200
Message-ID: <20260901220811.3369666-1-stian@itx.no>
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

Stian Halseth (2):
  sparc64: add seccomp filter support
  selftests/seccomp: add sparc64 support

 arch/sparc/Kconfig                            |  2 +-
 arch/sparc/include/asm/seccomp.h              | 15 ++++++++
 arch/sparc/include/asm/syscall.h              | 11 +++---
 arch/sparc/kernel/entry.h                     |  2 +-
 arch/sparc/kernel/ptrace_64.c                 | 28 ++++++++++-----
 arch/sparc/kernel/syscalls.S                  | 28 +++++++++++----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 35 +++++++++++++++++++
 7 files changed, 98 insertions(+), 23 deletions(-)

-- 
2.45
