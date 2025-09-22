Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63811221F15;
	Mon, 22 Sep 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575138; cv=none; b=mku652zlTc2RVvcrNYyZlIoExrUdr2R1NQQT0t4r4eVm5/xRzNY8Yr1szMRQaF3GdJ7R7BEzQrrH0T7DAMsfqN/kYtP8FIygTXRlmRGtlyUpGNIMJo5dItSFc1dUBP3l0cVNdqUqn6MuPeX/DS0O7cbrjlbp36u7m37IXLqV3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575138; c=relaxed/simple;
	bh=H6jgxamNB4CiaMFpOJ88VeRlAHqcew64WnBHEPiXMdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsr5tIQWojsbc3W8LnGg9wIDC66OvJ2bOrBPlXUQfV1dC0wgO7nSYUmReo9OAhAkOXctVQCSnddfcR6f/+arPe1b1ys93S1GpsS1JFccD4vJBw9KQdO+tyszPVpsCWBy0X3xHtGk9bQ6CxspWeiNiZneSWD3YAcgPJQEL2QxeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zbk060Nz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zbk060Nz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aBdbeuS24hx9KiY05gImYJd7bh2ittcga39YctXtCs=;
	b=Zbk060NzIG6ygPJgZ22nuNZOQ1MoeklGEsHnpQoGVQoIQNmziI8sUVjvATaCnmeAwukHCg
	2sEVAcMIDEC7VKBENGY1L4oRIamOvsopQWMBdl1XpPHiLWGUTdhoGFe80YvyntkUCnZiXp
	XBEcOIGU9WTfznxuQg6QeW0/czREsSQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] sparc: parport: Replace deprecated strcpy with strscpy in ecpp_probe
Date: Mon, 22 Sep 2025 23:03:51 +0200
Message-ID: <20250922210408.1723452-2-thorsten.blum@linux.dev>
In-Reply-To: <20250922210408.1723452-1-thorsten.blum@linux.dev>
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/include/asm/parport_64.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/parport_64.h b/arch/sparc/include/asm/parport_64.h
index 3068809ef9ad..78f14d6620bf 100644
--- a/arch/sparc/include/asm/parport_64.h
+++ b/arch/sparc/include/asm/parport_64.h
@@ -9,6 +9,7 @@
 
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/string.h>
 
 #include <asm/ebus_dma.h>
 #include <asm/ns87303.h>
@@ -149,7 +150,7 @@ static int ecpp_probe(struct platform_device *op)
 	sparc_ebus_dmas[slot].info.callback = NULL;
 	sparc_ebus_dmas[slot].info.client_cookie = NULL;
 	sparc_ebus_dmas[slot].info.irq = 0xdeadbeef;
-	strcpy(sparc_ebus_dmas[slot].info.name, "parport");
+	strscpy(sparc_ebus_dmas[slot].info.name, "parport");
 	if (ebus_dma_register(&sparc_ebus_dmas[slot].info))
 		goto out_unmap_regs;
 
-- 
2.51.0

