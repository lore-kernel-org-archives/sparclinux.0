Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002948;
	b=RxSJjoWWIb2RGRjcEALKSjeSPxLtW38yBm1Bt0mQQaydNbJhcxTbuv7wULRaZgs0HFda
	 yZ5ZSVY+IwAdePhbVJvTDvzg/l4jmPpECxNzN5FLzBmcjlCCIIlS50f7n9czMgm++UvpB
	 kfFzrBUbGElqcXIaDWOzC733H4J9wdsUerX/dQkRWcwbumObGyBBsX04F5uDPGWpAqNkK
	 EQqeWCWY+Yp84No+UasnnXMZQYqpLaA7E1JG+CjNRj1dZUZkqPj3jWQo9Syqoeok5zcJn
	 IFTeMyP0Qy3P/+nKesI5qpWbIctDUOBR+JCDjsU8zQ0kCRLZ7JZZ22kzxQsiPj2cGDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002948;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JxsGFp/2mL1MWpERUevRVtsMpsZ7wUJ4wyMIDIAEL6Q=;
	b=mWXl2qh2Mr7G7OlCbgV0e7YVSwFS1qN0dwuRYllEIsQa3CRDDnwLbHp1+PchoPO99U9o
	 eL1p4/2UFdsCLKxX7tnjekQzZ8BKaieS4QSpHLtN1H9P3EmtRYdJWn4U8ifBW0XMUj0G9
	 ZR94L28aCH8EVt/NaX8W6I6XNx+xjLqUu05UxuqML6QdhR5y+/grhxKBCuysWDSCFei1c
	 3gTYoS1DWbnIkebxGkGaOHkoOmDVDxR0kjXedJUQ59nnx47u3cjc/u7NMGZooZB7vK1fE
	 3ZsWWhEBhF4IWbXV39FXctYz46lUxJ/u03KOoEsN5Ic5rdBoCf75ZuNSUgEKIEUOyag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=KiTlGlOL;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE386606A320;
	Wed, 18 Nov 2026 11:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE386606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=KiTlGlOL
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1795002945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxsGFp/2mL1MWpERUevRVtsMpsZ7wUJ4wyMIDIAEL6Q=;
	b=KiTlGlOLbPO4l75a39XCAG3xwIhg9T5IEe+OrIvP4hE923N6q9G01HdhjzObbQzydnjQZS
	hOrfpKoWfIpkUwjcoJ2tvMLfbUz0wk+Ycpn1goutSwO/TJJdmmvhUrQCWnM/Zl9178Mvg2
	HvhO5k4P6aU5cNL2DJE6j/CE+Ga5gFs=
To: sparclinux@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 2/2] sparc64: Read qemu,hwcap-list from the OF cpu node on sun4u
Date: Wed, 18 Nov 2026 12:55:37 +0100
Message-ID: <20261118115537.160675-3-stian@itx.no>
In-Reply-To: <20261118115537.160675-1-stian@itx.no>
References: <20261118115537.160675-1-stian@itx.no>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPARC crypto opcodes are used only when hwcap-list names them.
Only the sun4v machine description carries a hwcap-list. QEMU's
default sparc64 machine is sun4u and has no machine description. The
kernel then never uses QEMU's crypto instructions, and the crypto
KUnit tests only exercise the generic code.

For CPUs with the crypto feature, QEMU passes a hwcap-list to the
firmware. OpenBIOS puts it on the cpu node as qemu,hwcap-list. Real
sun4u firmware has no such property.

Factor out the hwcap-list parser. When there is no machine
description, read the list from that property.

Signed-off-by: Stian Halseth <stian@itx.no>

Tested-by: Eric Biggers <ebiggers@kernel.org>
---
 arch/sparc/kernel/setup_64.c | 63 ++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 96de9fe84cd44..dde144adec82a 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/start_kernel.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 #include <uapi/linux/mount.h>
 
 #include <asm/io.h>
@@ -466,25 +467,9 @@ static void __init report_hwcaps(unsigned long caps)
 		printk(KERN_CONT "]\n");
 }
 
-static unsigned long __init mdesc_cpu_hwcap_list(void)
+static unsigned long __init hwcap_list_caps(const char *prop, int len)
 {
-	struct mdesc_handle *hp;
 	unsigned long caps = 0;
-	const char *prop;
-	int len;
-	u64 pn;
-
-	hp = mdesc_grab();
-	if (!hp)
-		return 0;
-
-	pn = mdesc_node_by_name(hp, MDESC_NODE_NULL, "cpu");
-	if (pn == MDESC_NODE_NULL)
-		goto out;
-
-	prop = mdesc_get_property(hp, pn, "hwcap-list", &len);
-	if (!prop)
-		goto out;
 
 	while (len) {
 		int i, plen;
@@ -510,11 +495,53 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 		len -= plen;
 	}
 
+	return caps;
+}
+
+static unsigned long __init mdesc_cpu_hwcap_list(void)
+{
+	struct mdesc_handle *hp;
+	unsigned long caps = 0;
+	const char *prop;
+	int len;
+	u64 pn;
+
+	hp = mdesc_grab();
+	if (!hp)
+		return 0;
+
+	pn = mdesc_node_by_name(hp, MDESC_NODE_NULL, "cpu");
+	if (pn == MDESC_NODE_NULL)
+		goto out;
+
+	prop = mdesc_get_property(hp, pn, "hwcap-list", &len);
+	if (prop)
+		caps = hwcap_list_caps(prop, len);
+
 out:
 	mdesc_release(hp);
 	return caps;
 }
 
+/* sun4u has no machine description; QEMU lists the caps here. */
+static unsigned long __init of_cpu_hwcap_list(void)
+{
+	struct device_node *dp;
+	unsigned long caps = 0;
+	const char *prop;
+	int len;
+
+	dp = of_find_node_by_type(NULL, "cpu");
+	if (!dp)
+		return 0;
+
+	prop = of_get_property(dp, "qemu,hwcap-list", &len);
+	if (prop)
+		caps = hwcap_list_caps(prop, len);
+	of_node_put(dp);
+	return caps;
+}
+
 /* This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
  */
@@ -552,6 +579,8 @@ static void __init init_sparc64_elf_hwcap(void)
 	cap |= (AV_SPARC_MUL32 | AV_SPARC_DIV32 | AV_SPARC_V8PLUS);
 
 	mdesc_caps = mdesc_cpu_hwcap_list();
+	if (!mdesc_caps)
+		mdesc_caps = of_cpu_hwcap_list();
 	if (!mdesc_caps) {
 		if (tlb_type == spitfire)
 			cap |= AV_SPARC_VIS;
-- 
2.43.0

