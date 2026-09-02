Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464A4A3F09
	for <sparclinux@vger.kernel.org>; Wed,  2 Sep 2026 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360385; cv=none; b=PviDONsn0gsjnwFgKLK9GJj7Kk7N/d247KJghFNKJ2LoZCRnpoHl1tUoFjb7PRRCo83ZGWyVH/6Rtiycg9E90z7OlB4RzJr08pO2qTnlBXWt2AHyPnSgzhFkW2+SquhMalBeMQXsbaYXq48KiX503V7EbFRgFUZB3zagOwX5MDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360385; c=relaxed/simple;
	bh=4IaYU5F5ZUse8/txNRWQkXrU6IWQl/7zD1+mzEskZsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7hhzaZQJrMG7o8dw9Si85KGTBNTAcIaZZTczEHWa2o35rKZZaD+6/wau2Q3quznerRu4L0ukujiv7zDV/pxtE+ocpk9hHlmXMrY2+HYervI+wIY6dS/T2hsSPsOKFp6fRn2SSbrW2U8jkRjb55UAFbYnjWSEBGG0cCOmdfjXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJDYzkz8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJDYzkz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7y9W91HQGBu0H2CHYYe7IynyY+rFM6Tt6aZ3QhTjIQ=;
	b=ZJDYzkz82IKHld9P6uBZPzyYzu0hvREP7kDKrl9jzQkK246JcLUgKyShsvZWqfD9DbX7/d
	3nKYVFgR1qmiCDbI0hyAaYGDDRMKz/1/NpFqsgZ+DGgdtbjQWpudmMVB6RDb9rHZYVwBqv
	LfUO5icyZIrHvvEtEvlDlzphNzwQQ2k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-dCVeTZG2PKK-c4lSlVKL2A-1; Wed,
 02 Sep 2026 10:46:16 -0400
X-MC-Unique: dCVeTZG2PKK-c4lSlVKL2A-1
X-Mimecast-MFC-AGG-ID: dCVeTZG2PKK-c4lSlVKL2A_1788360371
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52069180133D;
	Wed,  2 Sep 2026 14:46:11 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5965E1800643;
	Wed,  2 Sep 2026 14:45:58 +0000 (UTC)
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
Subject: [PATCH v2 09/13] parisc: pass pt_regs to audit_syscall_entry()
Date: Wed,  2 Sep 2026 11:43:42 -0300
Message-ID: <83d9a03e1fa526aef9f2ecac704c118a156401d7.1788351089.git.rrobaina@redhat.com>
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
 arch/parisc/kernel/ptrace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 1d9e210702e1..948e0cf29ba4 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -359,15 +359,10 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 #ifdef CONFIG_64BIT
 	if (!is_compat_task())
-		audit_syscall_entry(regs->gr[20], regs->gr[26], regs->gr[25],
-				    regs->gr[24], regs->gr[23]);
+		audit_syscall_entry(regs->gr[20], regs);
 	else
 #endif
-		audit_syscall_entry(regs->gr[20] & 0xffffffff,
-			regs->gr[26] & 0xffffffff,
-			regs->gr[25] & 0xffffffff,
-			regs->gr[24] & 0xffffffff,
-			regs->gr[23] & 0xffffffff);
+		audit_syscall_entry(regs->gr[20] & 0xffffffff, regs);
 
 	/*
 	 * Sign extend the syscall number to 64bit since it may have been
-- 
2.55.0

