Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC511E1C02
	for <sparclinux@vger.kernel.org>; Sun, 17 Aug 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755473037; cv=none; b=aAtTwT49WNEK5OmgCyP6I/WFjZ80GJvq/7+ccl6KhVcj1LaspPqIUAlA3HY7hO8q51zcdBFYzNYvghV2s37XJFB+CiWnRD20kyLJNXYnQDcjksIvG7Qjavx2z5oZfYwdTVMZ+JMZqOytM2jGk0um8Z0PKWEjGiNRM3LKQ9HU9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755473037; c=relaxed/simple;
	bh=+syUSoXzn8pOd0qDh0tgVdOLd8Wu+Lh0DW1WupAKD20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJUMD+tB6JdANJ9ifKRioPQboEjY7D4k5nRHFEBT1QFA7pSn//+NnHA9A9fNXpyhkeVVxJTExlPpJUIpVr9i1gfZxn34VlL4RazN/sx7UEJAohfjC5JKc4NM6etaWErQHm8iFOXnJburI8YF+ii7jLSyuvnsh4l9LrDdkpvcu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cXid9uT1; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cXid9uT1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755473034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wCMJPrdDQgHXKou2tP07iAww9tGuU+kjFqrxVf//los=;
	b=cXid9uT1mhOnVX47/C7ggGLW6s3aekxJunBt0vEOOeEYtdWe9R8cNpQ96JdvdoEuNZXrpP
	ubBM6f9le/z72+XlVSvMqES7PHdxQ7nexb5XX/vlH2GVQ3skFjArioRfREgVmKFvuywxCP
	AlstRDzVMfPIZH5zogkgOAO9En0Pjh0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sparc: PCI: Replace deprecated strcpy() with strscpy()
Date: Mon, 18 Aug 2025 01:23:36 +0200
Message-ID: <20250817232339.634641-1-thorsten.blum@linux.dev>
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
 arch/sparc/kernel/pcic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 25fe0a061732..f894ae79e78a 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/jiffies.h>
 
 #include <asm/swift.h> /* for cache flushing. */
@@ -352,7 +353,7 @@ int __init pcic_probe(void)
 	pbm = &pcic->pbm;
 	pbm->prom_node = node;
 	prom_getstring(node, "name", namebuf, 63);  namebuf[63] = 0;
-	strcpy(pbm->prom_name, namebuf);
+	strscpy(pbm->prom_name, namebuf);
 
 	{
 		extern int pcic_nmi_trap_patch[4];
@@ -477,7 +478,7 @@ static void pcic_map_pci_device(struct linux_pcic *pcic,
 	int j;
 
 	if (node == 0 || node == -1) {
-		strcpy(namebuf, "???");
+		strscpy(namebuf, "???");
 	} else {
 		prom_getstring(node, "name", namebuf, 63); namebuf[63] = 0;
 	}
@@ -536,7 +537,7 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 	char namebuf[64];
 
 	if (node == 0 || node == -1) {
-		strcpy(namebuf, "???");
+		strscpy(namebuf, "???");
 	} else {
 		prom_getstring(node, "name", namebuf, sizeof(namebuf));
 	}
-- 
2.50.1

