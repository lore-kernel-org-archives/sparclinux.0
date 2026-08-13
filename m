Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF683499F3A
	for <sparclinux@vger.kernel.org>; Thu, 13 Aug 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640791; cv=none; b=cDrJnCLjkTSqfLLWQhQe66mKkDZsfJrcxyd+Bf72Qg3zhOBEkEJpOiGtCB+bBDRYYDu3H6+af2sVy1dLLGAZ61WNU0O+hOOGNi+W6i6p7Ii8d3X+2EveF+edyPmTyjOhRIMnFoxrxGjqJMI17Ajdyx1Xpj8sVg+R4eZQce3GIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640791; c=relaxed/simple;
	bh=NpNfO1oxWkx5Q2CNwypUnwKHU6qaSbdW69UUIfjLVL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l25DQ687TJGPaK24as3BVxEwKHnc4wxLOLudOEEoQPkq1V/yt0lladtQvPSJxGhysxPewOOANNLfdtV6kJyead6ov+Z62n2YhOQNp07ZITMKGX7Nk9Gl8N+KaeeSk/bVrEo9/S6iPjawCv1O3tjDt55VCUDW6xYLjRFRLtm9mJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fo5lpGq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fo5lpGq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0X07In1qldTGybmdx53x+y5tR/aR+S5pQLXMdfQFUQ4=;
	b=Fo5lpGq1Z2/nanr08V/STbg7HjMCnGqnrjRU7PVif5jrfTp+1uDomGV9o/ETEmdvHfy9Zk
	MSra1q01SdBTAPzHbBAFI6aD6mp0APQaaFY/wWvMMOer1DnI8ZG7n28wI58UsD3luFDU3s
	bg+H0T6Ke7ldaj4PuSs8Qb/iitSf7n8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-HbeFCVHqOGGW_1hh13qClQ-1; Thu,
 13 Aug 2026 13:06:23 -0400
X-MC-Unique: HbeFCVHqOGGW_1hh13qClQ-1
X-Mimecast-MFC-AGG-ID: HbeFCVHqOGGW_1hh13qClQ_1786640778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B963618001E6;
	Thu, 13 Aug 2026 17:06:18 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7586A195608A;
	Thu, 13 Aug 2026 17:06:06 +0000 (UTC)
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
Subject: [PATCH 12/13] um: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:03:02 -0300
Message-ID: <c4118be04a7247aca96de49950dd5d866aa352b8.1786626275.git.rrobaina@redhat.com>
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
syscall arguments (UPT_SYSCALL_ARG5, UPT_SYSCALL_ARG6) now that
the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/um/kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index fdbb37b5c399..c597a368592d 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -127,7 +127,9 @@ int syscall_trace_enter(struct pt_regs *regs)
 			    UPT_SYSCALL_ARG1(&regs->regs),
 			    UPT_SYSCALL_ARG2(&regs->regs),
 			    UPT_SYSCALL_ARG3(&regs->regs),
-			    UPT_SYSCALL_ARG4(&regs->regs));
+			    UPT_SYSCALL_ARG4(&regs->regs),
+			    UPT_SYSCALL_ARG5(&regs->regs),
+			    UPT_SYSCALL_ARG6(&regs->regs));
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, UPT_SYSCALL_NR(&regs->regs));
-- 
2.55.0

