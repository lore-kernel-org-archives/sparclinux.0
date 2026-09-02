Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EA474246
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360407; cv=none; b=i8vfUoF7dJ/nItB7gEUM6QCNzphahBXFUFjFbn3IQDKGpWYxB2tHd4TKecpSjDmN6z3issQRMiQz/8BprHVxcayols4xI0igCbjWxXR0cL7EvOhAguxo4LnSrgrcyOphZSxUpWo66fQqL2GRxCyPlFj5CfhVGWiAIaqaQ62ZJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360407; c=relaxed/simple;
	bh=g/z2c0uejjbvW+bTUcXx6A5unb4ZHFpYUUEpYX5hIYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUJ0agwwx8S4mBmjFQSP6U85RaT3bXZ5YUBDwjMuvludl8s1EU+QGbiDVuqkVFqYxCIyJosgwLddQegCpe/Z/ZO2S+w77jX9YkxlxHxfNGAk+AI92F2g6npllQJDtcFL6kWUgRvETnu2lFcHdlkHAPxvAQtXXxfYnlHXJtLfPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMJyK/d/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMJyK/d/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+wbQbDqSGkxHemqbPjciPTDnnklfXLc74JSqQp6y6I=;
	b=TMJyK/d/UnjOWmj+2vMZDGSBY19zXzzvmRarEhaMZfSMNorCbCB5wtEI6Ljc0HzJGqLCak
	UzWI7QNJosUdMQxPYwXmaw1ODDbv/ZBZAJLqGNChGo+0OTZHUzaPB3PItPzvSLk8y8HV8C
	WeUK1yJzDXObsu+IKUm1V1rxyycxeyg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-O9slN2rfNGSVNs8IHLvaPA-1; Wed,
 02 Sep 2026 10:46:40 -0400
X-MC-Unique: O9slN2rfNGSVNs8IHLvaPA-1
X-Mimecast-MFC-AGG-ID: O9slN2rfNGSVNs8IHLvaPA_1788360395
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C6021954AF4;
	Wed,  2 Sep 2026 14:46:35 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8846F1800641;
	Wed,  2 Sep 2026 14:46:23 +0000 (UTC)
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
Subject: [PATCH v2 11/13] sparc64: pass pt_regs to audit_syscall_entry()
Date: Wed,  2 Sep 2026 11:43:44 -0300
Message-ID: <336fa8f8d896ca7989bc483b53fdefe2152a16f9.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <cover.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/sparc/kernel/ptrace_64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 825ddf55fece..b162585b4a74 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -1098,9 +1098,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->u_regs[UREG_G1]);
 
-	audit_syscall_entry(regs->u_regs[UREG_G1], regs->u_regs[UREG_I0],
-			    regs->u_regs[UREG_I1], regs->u_regs[UREG_I2],
-			    regs->u_regs[UREG_I3]);
+	audit_syscall_entry(regs->u_regs[UREG_G1], regs);
 
 	return ret;
 }
-- 
2.55.0

