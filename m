Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984B4963A7
	for <sparclinux@vger.kernel.org>; Thu, 13 Aug 2026 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640717; cv=none; b=RBefSXuhv45RD1aDeqFoMGrl0zFfsZHvozpeKhiX+0+f0YlHzjzSTyJvaIwuApVY6eMgqNWfVVNhwc9SP6tHXc+YK+oh3bVefdJwI6disnoin63lA6aCiAAFI2/LB13sLmF8qudaiv/4rpVKuruyVsyt47jojfwsTvLBwXi6BJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640717; c=relaxed/simple;
	bh=GbfZpaJBd81q0U+Y+6xRQMaEOr/17VF6ef/kRJ6DddU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epIOi2vXGJJr195ilQq7psTvM9R72TTvSkk9QYELdWV22g5HDsqLFiiNKfKb0MqtBCRKF/YCi6t5yezMQxVSdAJ+7nEFTj2B5rCiXbvZ17p7ENVKew9B3klY29vbDOwlX21mJtE4QEbv24BvcwXAcCf95RzN4F9iQmC4fsCFxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/E/BnPY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/E/BnPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hWmoGsUF+splwZL2Jc4XbPhM/cn3FE+Io5Xgg3E/U0=;
	b=G/E/BnPY5yEBFF6UoVlV2UoMVEhGIiMP2X0eB4TEBS2iNLo5l4DRju4VBeXiLy6CRbQoUS
	PSxCGlaTLvDVCOZ/aBK+jMZnWRChjWFkOOuVN9vDEYEJFRnyo1niVwE+tNxUOgzWVeBk1c
	fyst6/Nk88MRtfZvlsXpIzbt+eVAkdY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-gbL4XSmqN4CGUkdxqhGf9w-1; Thu,
 13 Aug 2026 13:05:07 -0400
X-MC-Unique: gbL4XSmqN4CGUkdxqhGf9w-1
X-Mimecast-MFC-AGG-ID: gbL4XSmqN4CGUkdxqhGf9w_1786640703
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80F231955E76;
	Thu, 13 Aug 2026 17:05:02 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85526195DF98;
	Thu, 13 Aug 2026 17:04:49 +0000 (UTC)
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
Subject: [PATCH 06/13] microblaze: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:56 -0300
Message-ID: <eb3d7ae5d98f6b377a376bdb4dd1b80dfcda8922.1786626275.git.rrobaina@redhat.com>
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
syscall arguments (r9, r10) now that the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/microblaze/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 5234d0c1dcaa..21bcd8dfe42d 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -147,7 +147,8 @@ asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
-	audit_syscall_entry(regs->r12, regs->r5, regs->r6, regs->r7, regs->r8);
+	audit_syscall_entry(regs->r12, regs->r5, regs->r6, regs->r7,
+			    regs->r8, regs->r9, regs->r10);
 
 	return ret ?: regs->r12;
 }
-- 
2.55.0

