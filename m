Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEAE4A3D22
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360267; cv=none; b=LylysNLZ4OzoNGEG2yXBUOBgKM1w6bHmVRkm7qvW1NMTeGMW0yeQaPO2zIijSsbpj943OgVUsm5rqcwelPUsEEyu6/Y5y5+ieNM2cdZJJglmwPFbqNTzC3WPl82dxuuXwhFXULX90ec3np4KX+dcQRnBTypuBhYXXlNT5ACYvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360267; c=relaxed/simple;
	bh=PUzYQPg358Fw+8vCplV+Vd9W8fGaaTeSWjRuWnfZwLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwWnFlYNgQ71XJNTgbQHPK9mnuGWUa0jm1y4DMjxPM+/DYFw+d5EUhbxFfesps8Z8E/Bb0WQXVTsVZCuOENnmWm4r5fxPVRcouJ/ICfqd86c+WoBidKJ1kFCUGrRdHAVTKiE3GrltgOt3WBBkMc238oXv7OzAC9VmDsKZbeltcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9leQ1yD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9leQ1yD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U+aXXTqCSMT4v6m94l8wWsE7+DIKM+xtaz3ODxXPycs=;
	b=Y9leQ1yDg2P2qQve7SQRCrOnFQ2IevjZoTyAdlKBO/j1srQWFq+WbdcbAkuRU5VOwISeod
	W4kmSXwGNp0UotAfGTgTdEpXrmTdJcCHsMsFMHkxn8p+SIakx5vK+y+dpuwceHtdSgfI7+
	XThQnwH2rRmZrK3njU+tQgJ5JS6bq+M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-iOdmff8TMlenYO4gBNmrnQ-1; Wed,
 02 Sep 2026 10:44:19 -0400
X-MC-Unique: iOdmff8TMlenYO4gBNmrnQ-1
X-Mimecast-MFC-AGG-ID: iOdmff8TMlenYO4gBNmrnQ_1788360253
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DB891945CB6;
	Wed,  2 Sep 2026 14:44:09 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 070E21800641;
	Wed,  2 Sep 2026 14:43:53 +0000 (UTC)
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
Subject: [PATCH v2 00/13] audit: log all six syscall arguments in the SYSCALL record
Date: Wed,  2 Sep 2026 11:43:33 -0300
Message-ID: <cover.1788351089.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The SYSCALL record currently logs only four of the six syscall
arguments (a0-a3), silently discarding the remaining two. This
leads to the need for auxiliary records when audit-relevant
data lands in the 5th or 6th argument of a syscall.

This series extends the SYSCALL record to log all six arguments,
by adding arguments a4 and a5 inline within the existing record.

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

Changes in v2:
 - Rework the core change per Will Deacon's suggestion: instead of
   plumbing all six arguments through every architecture's syscall
   entry path, __audit_syscall_entry() now takes a struct pt_regs *
   and retrieves the arguments itself via syscall_get_arguments().
 - Per-arch patches now simply pass regs instead of the individual
   argument registers.
 - Fetch the arguments directly into context->argv, dropping the
   temporary array.

Ricardo Robaina (13):
  audit: log all six syscall arguments in the SYSCALL record
  alpha: pass pt_regs to audit_syscall_entry()
  arm: pass pt_regs to audit_syscall_entry()
  arm64: pass pt_regs to audit_syscall_entry()
  csky: pass pt_regs to audit_syscall_entry()
  microblaze: pass pt_regs to audit_syscall_entry()
  mips: pass pt_regs to audit_syscall_entry()
  openrisc: pass pt_regs to audit_syscall_entry()
  parisc: pass pt_regs to audit_syscall_entry()
  sh: pass pt_regs to audit_syscall_entry()
  sparc64: pass pt_regs to audit_syscall_entry()
  um: pass pt_regs to audit_syscall_entry()
  xtensa: pass pt_regs to audit_syscall_entry()

 arch/alpha/kernel/ptrace.c      |  3 +--
 arch/arm/kernel/ptrace.c        |  3 +--
 arch/arm64/kernel/ptrace.c      |  3 +--
 arch/csky/kernel/ptrace.c       |  2 +-
 arch/microblaze/kernel/ptrace.c |  2 +-
 arch/mips/kernel/ptrace.c       |  4 +---
 arch/openrisc/kernel/ptrace.c   |  3 +--
 arch/parisc/kernel/ptrace.c     |  9 ++-------
 arch/sh/kernel/ptrace_32.c      |  3 +--
 arch/sparc/kernel/ptrace_64.c   |  4 +---
 arch/um/kernel/ptrace.c         |  6 +-----
 arch/xtensa/kernel/ptrace.c     |  4 +---
 include/linux/audit.h           | 13 ++++---------
 include/uapi/linux/audit.h      |  2 ++
 kernel/audit.h                  |  2 +-
 kernel/auditfilter.c            |  2 ++
 kernel/auditsc.c                | 19 ++++++++-----------
 kernel/entry/syscall-common.c   |  4 +---
 18 files changed, 31 insertions(+), 57 deletions(-)

-- 
2.55.0

