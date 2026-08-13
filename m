Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE25495539
	for <sparclinux@vger.kernel.org>; Thu, 13 Aug 2026 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640701; cv=none; b=JGs2Ag5lORu5aGUBHwYW8UYj6Eb7OEBbipJysvG8JfO7msbG69S0ZwpSK8+gF2JkSr5MNHADZ7Om2mqddHLNgg0wd00lL/43hm/9WLurCwe3+fppQzsoRVWfZBmf9+DE2GMcXqN3Abp6bbKnd6sWdG9jT1cbugT+lUQLJiPKSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640701; c=relaxed/simple;
	bh=ROVvxQd1RBUsp3BLfPbpP5zvkH7LlYcGT22RZlveHG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdiRc7CZLXWVmuoZGrn6lHf3FG3l8UQwcW++JHwAnm/+5yNdalSD6jsZsCrXES3snH9H+WUwBAZS3YZBvjLJrmw6XYLw1DI3Fr7KOqblC9AZD0CVJQ6gKeVVuI94tDU9RaSxwfSrSj5aLy5cYpygxnFKXcK8TGo/s2pULUHAxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4q7cZNP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4q7cZNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoUr+H27+L/TVykPAPX1fThxJpoZ/Q7OPCOqzzA9raI=;
	b=P4q7cZNPkWxQfZynvOkhOr0aeREEbDzwrDhDDpa075DkJX9yKgBaPYiBYyBoyOaeEOgS5R
	bWc+X407poPA+DFOdE0HHUlhk59Nr+/WFxZBZCse1+WJ0ziC5tDBcvME8m6rlFaoDgxBAC
	qXAUxFGiWIW3rc7giIOS/0cqnAd/2oM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-IN5bJnN_OxCEbFxwlktk6Q-1; Thu,
 13 Aug 2026 13:04:55 -0400
X-MC-Unique: IN5bJnN_OxCEbFxwlktk6Q-1
X-Mimecast-MFC-AGG-ID: IN5bJnN_OxCEbFxwlktk6Q_1786640690
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 164D9195604C;
	Thu, 13 Aug 2026 17:04:49 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31DA8195608A;
	Thu, 13 Aug 2026 17:04:35 +0000 (UTC)
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
Subject: [PATCH 05/13] csky: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:55 -0300
Message-ID: <0b18395deee1e30aaa53e4cc402f93e6e273a9ad.1786626275.git.rrobaina@redhat.com>
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
syscall arguments (a4, a5) now that the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/csky/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 6bb685a2646b..562eaf23be82 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -329,7 +329,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
-	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1, regs->a2, regs->a3);
+	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1,
+			    regs->a2, regs->a3, regs->a4, regs->a5);
 	return 0;
 }
 
-- 
2.55.0

