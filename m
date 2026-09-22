Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75514A1DEE
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104863; cv=none; b=pmhEL6nmIXo9qCHskPHI+zo/8IpDKvs+3g6v50xWvhvquFCQ2DbTCqcE0OxRBRcmfr2NRGTYOGhYHOAtJqsgIRlm4foJuxlpsBUnFfu2FElpSL+Rra2VjeCfnk/zZqq3too+KTbHQiqkEc57SbblkMrjsKygGuh+feOPBpJ5U4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104863; c=relaxed/simple;
	bh=HNLThOlE1asNKxutytllN747m0edkEmIk81s1jcMJjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AyRTQ1sLs0NvCt+emO7t1JAv0Ct3I+PkL6knCPlaQ4bmdgAwsBUYzod8or1BVb0c1pNgxahNH9jWPWVxddNqIJGTYAtESrsgWWPhUM3lzTWp0adp/wrKhTreXa8zV05tsFLAlrhTvScpcmOUF3TGopptusroNdWeOCp4T16+xIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdAf5fr6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdAf5fr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790104860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kEUEdL6PQ0y4Z2Ibs3e9Oc0v1TI6Cd/Tg+0kQahnhZg=;
	b=YdAf5fr6dM9JW3M5ufwEpaPGKwLMI8/KkDSGf5Bxv1kl8ixZ9EXKAo8VsMB69q2WDIcjud
	b4K9Q9xF85cnenDJv6yfIH6Y5J6jfLDILBm1hvD4CkAtg6nf9HwR/3/AMeLTHJ/Eikl8Pu
	NSJTYpwCER11IzZjAU4h2stICSY+Wg0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546--qBL0tg0PMOQ1u-kgEOasQ-1; Tue,
 22 Sep 2026 15:20:56 -0400
X-MC-Unique: -qBL0tg0PMOQ1u-kgEOasQ-1
X-Mimecast-MFC-AGG-ID: -qBL0tg0PMOQ1u-kgEOasQ_1790104852
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E30618011F0;
	Tue, 22 Sep 2026 19:20:47 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F291530001B9;
	Tue, 22 Sep 2026 19:20:23 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v3 00/14] audit: log all six syscall arguments in the SYSCALL record
Date: Tue, 22 Sep 2026 16:19:52 -0300
Message-ID: <cover.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The SYSCALL record currently logs only four of the six syscall
arguments (a0-a3), silently discarding the remaining two. This
leads to the need for auxiliary records when audit-relevant
data lands in the 5th or 6th argument of a syscall.

This series extends the SYSCALL record to log all six arguments,
by adding arguments a4 and a5 inline within the existing record.

Rather than plumbing two more argument registers through every
architecture's syscall entry path, audit_syscall_entry() now takes a
struct pt_regs * and retrieves all six arguments itself via
syscall_get_arguments(); the per-arch patches simply pass regs. The two
new arguments are also wired into the audit filter, so rules can match
on a4 and a5.

To keep the series bisectable, the new pt_regs-based helpers are added
first (patch 1), each architecture is converted one per patch, and the
final patch removes the legacy argument-register helpers and renames the
new ones back to audit_syscall_entry(). Every commit builds on its own.

The audit testsuite runs successfully:

 # make test
 make -C tests test
 Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  Fedora

 amcast_joinpart/test ................. ok
 backlog_wait_time_actual_reset/test .. ok
 bpf/test ............................. ok
 coredump/test ........................ ok
 exec_execve/test ..................... ok
 exec_name/test ....................... ok
 fanotify/test ........................ ok
 field_compare/test ................... ok
 file_create/test ..................... ok
 file_delete/test ..................... ok
 file_permission/test ................. ok
 file_rename/test ..................... ok
 filter_device/test ................... ok
 filter_exclude/test .................. ok
 filter_exit/test ..................... ok
 filter_inode/test .................... ok
 filter_saddr_fam/test ................ ok
 filter_sessionid/test ................ ok
 io_uring/test ........................ ok
 login_tty/test ....................... ok
 lost_reset/test ...................... ok
 netfilter_pkt/test ................... ok
 signal/test .......................... ok
 syscalls_file/test ................... ok
 syscall_module/test .................. ok
 syscall_socketcall/test .............. ok
 time_change/test ..................... ok
 user_msg/test ........................ ok
 All tests successful.
 Result: PASS

Changes in v3:
- Make the series bisectable, as requested by Will Deacon. Rather
  than changing __audit_syscall_entry()'s signature in place (which
  broke the build between the core patch and the per-arch conversions),
  patch 1 now adds audit_syscall_entry_regs()/__audit_syscall_entry_regs()
  alongside the existing helpers. The per-arch patches switch to the new
  helpers, and the final patch removes the legacy helpers and renames
  the new ones back to audit_syscall_entry().
- Drop the alpha conversion patch. Per Magnus Lindholm, alpha is
  being moved onto the generic entry framework, which removes its
  private syscall_trace_enter() and routes syscall auditing through
  syscall_enter_audit(); no alpha-specific change is needed once that
  series lands. This series should therefore be applied on top of it.
- Add "parisc: mask compat syscall arguments in syscall_get_arguments()"
  (new patch 8). Moving argument retrieval into syscall_get_arguments()
  would otherwise drop the low-32-bit masking parisc previously did
  inline in its compat audit path, exposing the upper 32 bits of the
  argument registers to audit (and seccomp) for 32-bit tasks. Mask in
  the helper instead, before the parisc conversion, so the series stays
  correct and bisectable.

Changes in v2:
- Rework the core change per Will Deacon's suggestion: instead of
  plumbing all six arguments through every architecture's syscall
  entry path, __audit_syscall_entry() now takes a struct pt_regs *
  and retrieves the arguments itself via syscall_get_arguments().
- Per-arch patches now simply pass regs instead of the individual
  argument registers.
- Fetch the arguments directly into context->argv, dropping the
  temporary array.

Ricardo Robaina (14):
  audit: log all six syscall arguments in the SYSCALL record
  arm: pass pt_regs to audit_syscall_entry()
  arm64: pass pt_regs to audit_syscall_entry()
  csky: pass pt_regs to audit_syscall_entry()
  microblaze: pass pt_regs to audit_syscall_entry()
  mips: pass pt_regs to audit_syscall_entry()
  openrisc: pass pt_regs to audit_syscall_entry()
  parisc: mask compat syscall arguments in syscall_get_arguments()
  parisc: pass pt_regs to audit_syscall_entry()
  sh: pass pt_regs to audit_syscall_entry()
  sparc64: pass pt_regs to audit_syscall_entry()
  um: pass pt_regs to audit_syscall_entry()
  xtensa: pass pt_regs to audit_syscall_entry()
  audit: rename audit_syscall_entry_regs() to audit_syscall_entry()

 arch/arm/kernel/ptrace.c          |  3 +--
 arch/arm64/kernel/ptrace.c        |  3 +--
 arch/csky/kernel/ptrace.c         |  2 +-
 arch/microblaze/kernel/ptrace.c   |  2 +-
 arch/mips/kernel/ptrace.c         |  4 +---
 arch/openrisc/kernel/ptrace.c     |  3 +--
 arch/parisc/include/asm/syscall.h | 18 ++++++++++++------
 arch/parisc/kernel/ptrace.c       |  9 ++-------
 arch/sh/kernel/ptrace_32.c        |  3 +--
 arch/sparc/kernel/ptrace_64.c     |  4 +---
 arch/um/kernel/ptrace.c           |  6 +-----
 arch/xtensa/kernel/ptrace.c       |  4 +---
 include/linux/audit.h             | 13 ++++---------
 include/uapi/linux/audit.h        |  2 ++
 kernel/audit.h                    |  2 +-
 kernel/auditfilter.c              |  2 ++
 kernel/auditsc.c                  | 19 ++++++++-----------
 kernel/entry/syscall-common.c     |  4 +---
 18 files changed, 42 insertions(+), 61 deletions(-)

-- 
2.55.0

