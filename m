Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A33B42EB;
	Sun, 30 Aug 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094585; cv=none; b=aPZQKPdSy06erS6Kg61CesPp1GsLIy1b15/zBMmoNbOS/pF3dRJKnF/vrjA8zQO2/N9MzbpbzLVuSJppfm2Vx1ZY+6FHYuIn3o3+SV0ASZPEPDkgKjcjbgwX7mOvkw4Jg7e0Uh8DbjF248iPVmoMdov8giuCA+xENZ2gYX6SBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094585; c=relaxed/simple;
	bh=H1zD2pLjI680g5/OJbjQdx7WVWDNX9BDJOGjwqEnQx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDraER+J0Kh9tB3IYEzlQtU5GTVeAADjTne5V7KHP87NfOrR/XQWuRr8tfV9myEly4omJAqGmaErTDC+SWcXQks1+vhYCjo+4f9prbL4nexJxP+81rGqdzJ3/o+jarQGT4t59lmCSVFXTobRKZPLzQJYfWpv5U8BMywQXr7Ti/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aFwuAh/h; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qDbDKdEs; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aFwuAh/h";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qDbDKdEs"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hXsZ554nfzMlK6;
	Sun, 30 Aug 2026 14:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788094573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RLZ0HwhGINaP5EA/WEgAvRaXyZ65SyZetSkgoRNegjU=;
	b=aFwuAh/hAFj9t1JCrVwFehKq7bri3P+IUqn+OjzIkyUQKgtszYwX42+hFOmb8D5mviPCSd
	Alf3CMFNVSSAi8gzI0tLN3R8KiHCnkk1m90GlFDzKLMbuXcj3/DuFaxh8VZRM9hXLVNkze
	bU1ggeyTRAKeZRI81sADI9wzua2m8dNUl6Q29N4Z36RTnZiNcDupMjF8iT/L8Bd5HNIxFC
	MLbrTvcaYNrlRYJ8yhh+VFp7TZ9fooC/w2t7moFOe4wNY0qDrmNLMcdnXTyH25xLT7w/5J
	epGgdbtQgMqEHFgXviljYFyoAw6Br5iR31JmH4TSwgD5dKcwP73QGPB/udwT7g==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788094572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RLZ0HwhGINaP5EA/WEgAvRaXyZ65SyZetSkgoRNegjU=;
	b=qDbDKdEs5Z1xu/eeejnuEFFKJq3CEX/v9kYH13We9X7v8LHaVQTC8lSVe9hRl9bMG5ZA0B
	n9EpWzWpEkuCZQwaG0v1Wie6rKej7/ChM4RJDnlLGO8O3fYrOvcfC58+a/FSG3e+7SGISG
	BOx/4Ow7hu+dHlPWavsigK8IXlIWacKGm357VMAoHrbyypaKi9Ok5Bscrw95//VawhgBAd
	sbBQF82g5iEwOXNNFMXjAJdaYQZyO7UmFmoLJTkXm9x7Y/xe+kyUb7+lG8ctdktC8FagKD
	Qg0LQIp9W2Y63vhM6wGQKxlwWqR98jV5G/6jpA1bxktDN72CrmxLFI+B1AVAZg==
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: NMI: Remove obsolete comment
Date: Sun, 30 Aug 2026 14:55:05 +0200
Message-ID: <20260830125506.632168-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jshafit6zj5y9j6jtdmotws7htgtawym
X-MBO-RS-ID: b19ad3c68e5209a608b

OProfile has been discontinued as of commit 8e9fa2f21151 
("oprofiled version output line removed from the list")

CC: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 arch/sparc/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 149adc094..1571d6298 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -41,7 +41,7 @@ static int panic_on_timeout;
  * <0: the NMI watchdog has not been set up, and cannot be enabled
  *  0: the NMI watchdog is disabled, but can be enabled
  */
-atomic_t nmi_active = ATOMIC_INIT(0);		/* oprofile uses this */
+atomic_t nmi_active = ATOMIC_INIT(0);
 EXPORT_SYMBOL(nmi_active);
 static int nmi_init_done;
 static unsigned int nmi_hz = HZ;
-- 
2.54.0

