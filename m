Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAB495539
	for <sparclinux@vger.kernel.org>; Thu, 13 Aug 2026 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640743; cv=none; b=FdzyHdZQ04vrU2gL5uNYHxzMRb8wVPO5lnni2vca/MIQ3UWbRKihcRcq6htD0cbQ/7OsFJxz8pCWpYlKJMMNElQ3Whaydc+YLqwLGqMd7h8v+avQUZ/PzvETnL6LHdiYPyaVv0OvWJCaKWfMf5xqcT7EMmxYAi06WTtJYoVZM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640743; c=relaxed/simple;
	bh=BF7Rk9ys0WDDHzHflGAuEI24btvVlm2FbGxQmoRlJhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su58ABAwnxbxpEK+08VADJngwdEHJ+KmOtBahv9UioPKANmPtScrXvf8PTaAeEOHFd4jvVInu3X4ol1VV+ju+svZO0MBTYyUKajnPU4AR3wOhR9R3s8ua/pB1RiBHF4psBB2XxPzwXhtSogBt/18TeDh76zitylh8PLcmYGS27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3xZjOuv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3xZjOuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7DByCcmMjMcU6fVtAV0LTF+gTPKITg6ZRJZBP5hclI=;
	b=O3xZjOuvmgIZTQ3imar8zUh3OWpSczKs0Ea+Ov2nRNhG6exfaV0xUBPG0l54GLgGQeegMk
	bgRnIu2stq4m6t5870RYA/wzUAt4uBP4sqkJFFXXUiYkaJzsH0P1Adg+L05ygWQgslYUIP
	D1Aq+6cUiOuxoeFEMoqlzZfxKwlX1q8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-dZ4Wkn9xN22gyZ5-MF-yqw-1; Thu,
 13 Aug 2026 13:05:34 -0400
X-MC-Unique: dZ4Wkn9xN22gyZ5-MF-yqw-1
X-Mimecast-MFC-AGG-ID: dZ4Wkn9xN22gyZ5-MF-yqw_1786640728
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2B841956071;
	Thu, 13 Aug 2026 17:05:27 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76CC6195DF98;
	Thu, 13 Aug 2026 17:05:15 +0000 (UTC)
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
Subject: [PATCH 08/13] openrisc: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:58 -0300
Message-ID: <1616198d0cfa9434b36fc1ac6055064ae8c08057.1786626275.git.rrobaina@redhat.com>
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
syscall arguments (gpr[7], gpr[8]) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/openrisc/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 552489b24855..197a616d6c65 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -302,7 +302,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		ret = -1L;
 
 	audit_syscall_entry(regs->gpr[11], regs->gpr[3], regs->gpr[4],
-			    regs->gpr[5], regs->gpr[6]);
+			    regs->gpr[5], regs->gpr[6],
+			    regs->gpr[7], regs->gpr[8]);
 
 	return ret ? : regs->gpr[11];
 }
-- 
2.55.0

