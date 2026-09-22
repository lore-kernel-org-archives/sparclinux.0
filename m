Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602448F03D
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105036; cv=none; b=WC0KoLwySy9i5ctWLVNl+/owiyc/P5NxT6L8KBlOqJLiWU5nGBbAMxDizr7rud/rLQn+H+eNFxKdhvIACs2btq35G5qAw78w4g2cX+iOLCC9NfbMMGqall/T62p86X5lahyl49SXo8et19WRALAU7OevKIRx+ViYEZAbJr0U+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105036; c=relaxed/simple;
	bh=AlEwOJCqXj75nlY4mRvsGPrbuus/qC7ZFbxnPlHbnpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTAf/o8lO9eCr1WGkfRYFoTy8Jn1v+zVZ7JWmqaR4rbd8NPiIh3qfKBq6ZyEkshSHRJHkmTIy4ZzLgqrVVdxEN4uYrWD5BGZ3JbdYexOHTQiSH/Upz+s7NDyehLJRI4sn+Mctdo0sKbvATuE4Ih4ZgMDcXIRQikyXg2GsjBZT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hr9HagQu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hr9HagQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790105033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4g6Pqq5n7M/gwYtRIbDe68QQcgDz6vnWXZj4Z/2+yek=;
	b=Hr9HagQubgKjjlAHzLQoJmfnXWlm858vkiJCrU34JrwL+Yo3RQUdrkDzhregsyWRUCp4DX
	5Wa9xtGfA1aXP/uqeqlSr+AFzvLJbpu0bU5bT0Lob1G3UsfEG1bFitgQgSJ6kdnFP6ILm8
	ChZ7/5UuJinhti1080kVAAyvqq8Uypk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-WgDPjhSqNVm4ukglLylNhQ-1; Tue,
 22 Sep 2026 15:23:50 -0400
X-MC-Unique: WgDPjhSqNVm4ukglLylNhQ-1
X-Mimecast-MFC-AGG-ID: WgDPjhSqNVm4ukglLylNhQ_1790105026
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3BAE1955E87;
	Tue, 22 Sep 2026 19:23:45 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E03C63000223;
	Tue, 22 Sep 2026 19:23:26 +0000 (UTC)
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
Subject: [PATCH v3 08/14] parisc: mask compat syscall arguments in syscall_get_arguments()
Date: Tue, 22 Sep 2026 16:20:00 -0300
Message-ID: <65f32a82d590b11984723fa6f26ff96175679f9a.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A 32-bit compat task may leave garbage in the upper 32 bits of the
argument registers. Mask it off in syscall_get_arguments() so that
in-kernel consumers such as seccomp and audit observe the same values
the syscall actually used.

This previously happened for audit in the parisc do_syscall_trace_enter()
compat path; do it in the helper so all callers benefit and to prepare
for passing pt_regs to audit_syscall_entry().

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/parisc/include/asm/syscall.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index c11222798ab2..9d10fada3b48 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -28,12 +28,18 @@ static inline void syscall_get_arguments(struct task_struct *tsk,
 					 struct pt_regs *regs,
 					 unsigned long *args)
 {
-	args[5] = regs->gr[21];
-	args[4] = regs->gr[22];
-	args[3] = regs->gr[23];
-	args[2] = regs->gr[24];
-	args[1] = regs->gr[25];
-	args[0] = regs->gr[26];
+	unsigned long mask = -1UL;
+
+	/* Mask off garbage in the upper 32 bits for compat tasks. */
+	if (__is_compat_task(tsk))
+		mask = 0xffffffff;
+
+	args[5] = regs->gr[21] & mask;
+	args[4] = regs->gr[22] & mask;
+	args[3] = regs->gr[23] & mask;
+	args[2] = regs->gr[24] & mask;
+	args[1] = regs->gr[25] & mask;
+	args[0] = regs->gr[26] & mask;
 }
 
 static inline void syscall_set_arguments(struct task_struct *tsk,
-- 
2.55.0

