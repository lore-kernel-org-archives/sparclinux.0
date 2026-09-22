Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F9494802
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104982; cv=none; b=oVIlrXqKF6D2/7Mx8D4EEZcq0AafyqfhuYmv0TjwJRp25pwCK38ZJjqXNJUW18pKv+3WiCqYjQJG/RBo8CgbOfr6HKhrbxNsGX6CtRmyuOwzUVZ83FK2JEaOQHyBpKjuvF24QpkrQip67z4uEFkVhcMV+zYKETQCADRd4oJynyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104982; c=relaxed/simple;
	bh=p/Z9tMB7L2aGlSR1rBtd/rXtDQgfW7fpyP5+y2Yh/rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S74Ms8CIbUvNwR329bfk6zlQs+c/lLoglJA2uUx++4iUV30McF6Ob/o5mh2NLZTvyxdai+aFQfDTjJ4/N0lT15nbrKiz6KYOmjDz/OzwViQVvnrdmETxyn620VMmzB6UK9X6AJW06/6vn/yGnV2+6ipSj+kJwwz3n0Tzy+1x6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7dW7njM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7dW7njM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790104979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZmcd8+UVmTX70fsiVoE5rvFQv/gCCUJFz3bb+eoWBI=;
	b=O7dW7njMDj8rj0nLtWbHGhJMcV6DC9C0Pdrg7AS+IEbYMt4OJWbJnW5dcMiPrS1OoZ0uPO
	V8CsOGSj8kUqmM8x+UgNVHuPtTlxGTPwFwf5txjSPOF3xo618R9hjLHzjFi3drD/jq8MwK
	FrUgSFJEftAEq6ZLwu3/tSUg/1sQEHw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-joQOHxrGOqy_Cpzz6IZdDA-1; Tue,
 22 Sep 2026 15:22:57 -0400
X-MC-Unique: joQOHxrGOqy_Cpzz6IZdDA-1
X-Mimecast-MFC-AGG-ID: joQOHxrGOqy_Cpzz6IZdDA_1790104972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AD2818007FD;
	Tue, 22 Sep 2026 19:22:51 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20CEA30001B9;
	Tue, 22 Sep 2026 19:22:31 +0000 (UTC)
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
Subject: [PATCH v3 05/14] microblaze: pass pt_regs to audit_syscall_entry()
Date: Tue, 22 Sep 2026 16:19:57 -0300
Message-ID: <8bf782579aa4e549f201e67856600b4a3445ad66.1790088067.git.rrobaina@redhat.com>
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

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/microblaze/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 236264e932d6..d0a540b7370f 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -147,7 +147,7 @@ asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
-	audit_syscall_entry(regs->r12, regs->r5, regs->r6, regs->r7, regs->r8);
+	audit_syscall_entry_regs(regs->r12, regs);
 
 	return ret ?: regs->r12;
 }
-- 
2.55.0

