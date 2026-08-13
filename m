Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6648CD5B
	for <sparclinux@vger.kernel.org>; Thu, 13 Aug 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640844; cv=none; b=ZOYZrcqpQsD3+BNj5Y03SGlHxe6Jv8N55MJmAJRUG/3fOLzqnePfVCC2C9tk5ESRBt1EZqDkZr0xitmCJrON80/vApp4lH/Xnvn9szMz074/pOqsAIQCjBbrMUa33AX3Vc4hEl/hI695EUyT8a9MsXl5MP926c4XByg/+Ha8LyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640844; c=relaxed/simple;
	bh=w0jbd1lgYBWjloNI+GXG0PPjt/OCDX0+pwpLokZvL6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqBT7tg2j0VP+9MlQDK5ax0VpxtpliPPqGXf5a/RVl/42bgvN3V4bNJ9V/cwqsuXwgETik3Jp63lDu//EO6SzdOUAKWOmpdt1o/ifuH9SQnfZJffuyqEdE3AOmjWW5ztGJ4fMWsNiua9YT46P94Ohr0BUKrKYE40mBDbg9ksGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jdnwu0SZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jdnwu0SZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpaakGs2Tf7xeoHHoL80KxzX2+hb3XlzydpXYC2fGY4=;
	b=Jdnwu0SZDNt1sqVnI84vSj4mqVHF/0nH7n8R6V0x+KLaWvpLlsvlDBch8AqeNR9tAarzky
	pk8Fg2evAOroAU5SKmX8Mp9TG/Tsh6duEK3WB5ISN6gnmzvwikEhfu9xds5THqxqxlzJlS
	r9kbHY585Wzk9/b35heWmOB+sSW4Xhg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-wBrpiqygOMm-ilyseSAiJg-1; Thu,
 13 Aug 2026 13:06:10 -0400
X-MC-Unique: wBrpiqygOMm-ilyseSAiJg-1
X-Mimecast-MFC-AGG-ID: wBrpiqygOMm-ilyseSAiJg_1786640766
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA6521955F3F;
	Thu, 13 Aug 2026 17:06:05 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 375D4195608A;
	Thu, 13 Aug 2026 17:05:53 +0000 (UTC)
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
Subject: [PATCH 11/13] sparc64: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:03:01 -0300
Message-ID: <fc2810a850a8bf343b7ad7ae9caf3da57e1f41ec.1786626275.git.rrobaina@redhat.com>
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
syscall arguments (UREG_I4, UREG_I5) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/sparc/kernel/ptrace_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 9fc67fa9336f..d0ad3200d789 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -1100,7 +1100,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 
 	audit_syscall_entry(regs->u_regs[UREG_G1], regs->u_regs[UREG_I0],
 			    regs->u_regs[UREG_I1], regs->u_regs[UREG_I2],
-			    regs->u_regs[UREG_I3]);
+			    regs->u_regs[UREG_I3], regs->u_regs[UREG_I4],
+			    regs->u_regs[UREG_I5]);
 
 	return ret;
 }
-- 
2.55.0

