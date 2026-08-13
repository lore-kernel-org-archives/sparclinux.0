Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A7499F20
	for <sparclinux@vger.kernel.org>; Thu, 13 Aug 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640765; cv=none; b=ICAkCIOPGz7CubVfEbuy1SuM5silG4b5uJTsnxV/NJ8VBXZU9IEMu1aVlJW+ZZLUlenmVyfm9huc47c63Qiuc9QyaZwEtMlri2PMcFBLXM1qS5lNWB64oD2uJAmQZNYcExZMhtir1E5bt3mDSuObedAn8MM8xo1H5oTpkz07l1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640765; c=relaxed/simple;
	bh=fWWVqwOTWCCSPtiWZgdZQXWWck9/HAOBYmYhJBJ4P7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6NQ85W5vVN1nN6gCXHpcDJNWqHknEe4WYKSKtQGrLgzx7byxcat8Hc7Pi+0Ql0SVhCBnUloz0YMaU+vkW3xR2ckUwa00tVUSpL2F00xKj0YqscSDEern4Iw0ZS6HtAfu3OnCLq77cIUL6lXQ+qvGqu76Q+Tk7i6iVeunu+gcyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUUpLXff; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUUpLXff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/fapztvh+JYJWSbiim6bS/NIIaWMImlcOIjrLe7Emw=;
	b=FUUpLXffMeeqflmXxott/1tKl804OB+VnWppe9TWqaQE0M7XasknkN7nSNQOaKxZlJq+1f
	ngH/g8hsU9cEh+W6b5pWbqQH4Z3DIunkiw/fGgOr62P6fY4ZEswN7hiuie1qF8rSINQ0kQ
	l09ZZpXIXd+zeUCUZ23OU6vIeF457n0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-zTkj5BKiPqGG_JDe6Pk0tQ-1; Thu,
 13 Aug 2026 13:05:46 -0400
X-MC-Unique: zTkj5BKiPqGG_JDe6Pk0tQ-1
X-Mimecast-MFC-AGG-ID: zTkj5BKiPqGG_JDe6Pk0tQ_1786640741
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3E701955F1B;
	Thu, 13 Aug 2026 17:05:40 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BBA5195608A;
	Thu, 13 Aug 2026 17:05:27 +0000 (UTC)
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
Subject: [PATCH 09/13] parisc: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:59 -0300
Message-ID: <90512a215fb9bdd39471c241057c097ed8b93186.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Update both the native and compat audit_syscall_entry() calls to
forward the 5th and 6th syscall arguments (gr[22], gr[21]) now
that the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/parisc/kernel/ptrace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 8a17ab7e6e0b..75e74d214a3b 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -362,14 +362,17 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 #ifdef CONFIG_64BIT
 	if (!is_compat_task())
 		audit_syscall_entry(regs->gr[20], regs->gr[26], regs->gr[25],
-				    regs->gr[24], regs->gr[23]);
+				    regs->gr[24], regs->gr[23],
+				    regs->gr[22], regs->gr[21]);
 	else
 #endif
 		audit_syscall_entry(regs->gr[20] & 0xffffffff,
 			regs->gr[26] & 0xffffffff,
 			regs->gr[25] & 0xffffffff,
 			regs->gr[24] & 0xffffffff,
-			regs->gr[23] & 0xffffffff);
+			regs->gr[23] & 0xffffffff,
+			regs->gr[22] & 0xffffffff,
+			regs->gr[21] & 0xffffffff);
 
 	/*
 	 * Sign extend the syscall number to 64bit since it may have been
-- 
2.55.0

