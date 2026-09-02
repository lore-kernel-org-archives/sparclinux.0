Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97A340416
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360349; cv=none; b=FKiw1NpeB/GeXZj2+z+jQrQobNWZ8h9vyqt8FI6txTwdnqKMKIcrk2TXSXIzHQDNQnlBHaYwLMsTAaPNiXu/CeKwQV7tMu3f6ecjQ9494ctKUWmkdk8cCVxDgq3MligrwKrEnW9kVFL+v/LD7XD2Gsmg1fVmcE+GBxIeYNU8230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360349; c=relaxed/simple;
	bh=8/GCA5LAxIagEVqfPnhqTs8UinXTcTM+5JmGK586QT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNj/1+nzv2bWfZlCcUc7CmQkAJ4o1cJi4JaHksH6Q42xgRPA2rptgk22FwE9+H3lrQ2ixKDP66HfRNNH7mc+4Y227s6DvwJ2umWM2zgZzLFlgDwL3pfKyvpAB2t9it2LNvkuiAQ9rbGn3rrg0laE6PPy7MgeA0bd2fzrZxBECZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSJbnX5N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSJbnX5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItBk91wHSYNF8sJoVrRHTmXutoGVHgHWsPITNC9iFGU=;
	b=cSJbnX5NuBpVXlTHsqicPmzyOQlYW6mkcNxiVJmCmlO9lygNRGeiXnkl+0SJ0kmsuRlWdf
	tFKxQG3HjHcJ9dq4l67Kr3s2Hx49t4qDrIvKEv91jZPfCxIwAxOVGloiYGBk0FWQ8L7K3c
	u78+S3kur1X+A28B/VJk7RjJtJX3oqo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-u0gr6a0fMcKlIaVx4XlB8Q-1; Wed,
 02 Sep 2026 10:45:45 -0400
X-MC-Unique: u0gr6a0fMcKlIaVx4XlB8Q-1
X-Mimecast-MFC-AGG-ID: u0gr6a0fMcKlIaVx4XlB8Q_1788360334
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DB4F18512F5;
	Wed,  2 Sep 2026 14:45:33 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B99D1800641;
	Wed,  2 Sep 2026 14:45:19 +0000 (UTC)
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
Subject: [PATCH v2 06/13] microblaze: pass pt_regs to audit_syscall_entry()
Date: Wed,  2 Sep 2026 11:43:39 -0300
Message-ID: <185aac22d5afd79ef50f170332a1a808ff0a5b0d.1788351089.git.rrobaina@redhat.com>
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
 arch/microblaze/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 236264e932d6..5fe9e3a150f4 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -147,7 +147,7 @@ asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
-	audit_syscall_entry(regs->r12, regs->r5, regs->r6, regs->r7, regs->r8);
+	audit_syscall_entry(regs->r12, regs);
 
 	return ret ?: regs->r12;
 }
-- 
2.55.0

