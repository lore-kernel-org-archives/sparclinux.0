Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317074A3F2C
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360433; cv=none; b=P3wmWR8oog4AqoM52Rlby+g4opfJusLoJ2ElBf6xET+6VcyuSpWkOKn8nCenO942Af0LVK2SmwuLftkmMnFMRALemZcMdseaxoNedidimEf9/4RN3jY1LE3RVRbe4Rm487RQYs6w+u4t3LDoZ8WM82uDCCG/2hcZPwyQu5lqMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360433; c=relaxed/simple;
	bh=kfiDLo+BxdeMyd7DwCKHFv96MicNeVsjL5sGevnIHXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhT68EPmTLVg/T0vfjGECYJPnixMKH0EBNWFCF1/g4pmOD1ZMrXSZwXKFiXFwe5GhJaPr21BMXbJZGFsDyeQaKSwPt/27Fj7F1clgdUfFojiGtvYSbqaHWa4iimSwrK+omqxJdvmgF0PlaWRhBi39Hyi48FgS/itq0nfCnY7CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAifUhAQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAifUhAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZoYau2WBD6IZMmGu3u7wBhLPz0DgKCouySyNxSkIQc=;
	b=hAifUhAQkhHvX5UPzdg+WHXMardvsaZTwR+xKJ722053L9Ic6YiFSnbQP7oVUwT02iwW2v
	KTuR3OEto5vKqVAkvL+o5q3iByxUj5ruLKQV88hiBrFPHMIoGhh9fGRijdvF3JjsUkWMdn
	QaSQmOeFo01VjauZjpDtHZRgtcZPI8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-6y8aj7x6Pwq6ejExRIcZDg-1; Wed,
 02 Sep 2026 10:47:04 -0400
X-MC-Unique: 6y8aj7x6Pwq6ejExRIcZDg-1
X-Mimecast-MFC-AGG-ID: 6y8aj7x6Pwq6ejExRIcZDg_1788360419
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C6DE19539B7;
	Wed,  2 Sep 2026 14:46:59 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F080B1800643;
	Wed,  2 Sep 2026 14:46:47 +0000 (UTC)
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
Subject: [PATCH v2 13/13] xtensa: pass pt_regs to audit_syscall_entry()
Date: Wed,  2 Sep 2026 11:43:46 -0300
Message-ID: <c484b749374ae3768e57f4e7148324c4a730bef2.1788351089.git.rrobaina@redhat.com>
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
 arch/xtensa/kernel/ptrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 364e4fdabb00..327e00c2ebde 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -561,9 +561,7 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
-	audit_syscall_entry(regs->syscall, regs->areg[6],
-			    regs->areg[3], regs->areg[4],
-			    regs->areg[5]);
+	audit_syscall_entry(regs->syscall, regs);
 	return 1;
 }
 
-- 
2.55.0

