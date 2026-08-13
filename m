Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C499F25
	for <sparclinux@vger.kernel.org>; Thu, 13 Aug 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640764; cv=none; b=WtyzhWG1aZq/1pXY2SzZMkmc6rP8eRMfrnLf+zA45aD0g2//2VSDy9vnSdtuc9vJBTPmv31YND21kS5/U4C0dCAxFY9Sfb7YyqaYkxkmm4xJV0Wl1XZR2JiJU+63XyrvQG+rJz0OJ47dNnYqohSx9rxtitw3Zat6ZTOR1aTvTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640764; c=relaxed/simple;
	bh=GQUGo/K0SSZv8gZ1d5IhkMoOWnLCmA4LLvNgg0xtwHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWRWbSJWrOGW6SqJxDZ5TPZnBbn3Qk/ArhRaTB7Z/VQE5KppLRCZq+XI3+yHkAg3wMp5B/QUUoH0qbk2RFjsNXDU0Hovz/hR2/CF+c12ZvYiUG+i5EK1CcVHT8+ir7FwpR5ZM/FTbCc4oyp3MDnP0Yg5ioZCRwjJSX9nNJUTYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXtO8MXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXtO8MXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PT2ri8aRhgjrTVSTpNbQtsdRkL9ZTdzAq1eD0J7E/1k=;
	b=aXtO8MXCG2wcq1iEgYrktlt4Y7+3Dl9r7uo/+90Iyhj9O/ClRKU0g6jbrW/M7HSpZBa0Tq
	xHHK27DkZz/sfe1osicsvKD847Cpx92gWFKVPi1EsQEKgXJGaSSmvlmPDOxKX2PMapiD4F
	oqIUQt7ssUo1px1MNH7aH6b9SPXrI+Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-wSnG0OpgNy-hiywKDHrLxQ-1; Thu,
 13 Aug 2026 13:05:58 -0400
X-MC-Unique: wSnG0OpgNy-hiywKDHrLxQ-1
X-Mimecast-MFC-AGG-ID: wSnG0OpgNy-hiywKDHrLxQ_1786640753
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6931955DC9;
	Thu, 13 Aug 2026 17:05:53 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F3A4195608A;
	Thu, 13 Aug 2026 17:05:40 +0000 (UTC)
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
Subject: [PATCH 10/13] sh: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:03:00 -0300
Message-ID: <be964ca4e6854db2a66cbba4af1ff2fdd769e752.1786626275.git.rrobaina@redhat.com>
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

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (regs[0], regs[1]) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/sh/kernel/ptrace_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 06f765d71a29..3efefd67b457 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -467,7 +467,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		trace_sys_enter(regs, regs->regs[0]);
 
 	audit_syscall_entry(regs->regs[3], regs->regs[4], regs->regs[5],
-			    regs->regs[6], regs->regs[7]);
+			    regs->regs[6], regs->regs[7],
+			    regs->regs[0], regs->regs[1]);
 
 	return 0;
 }
-- 
2.55.0

