Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914967;
	b=AYjBhUNR7dLUSRVe/E5GvqUvBuPFbHe6c0aLYO5HwOMfHpWLPnsHC/cxFBYJj+3roKeE
	 Ls+xdF5dmC4Gpk64DK1eUK71aPrQeUVoCgcEP7EnElFIaq8GrOsgvx50mqtACV+uD6jgS
	 /AXizrw2gLK1nUQ0LGPKUmSjaYuV6weHXzodXsT4m8GxVV+Gq/t3ctkHHrUhKkFUgix1v
	 mU1kDTZ+7OfE8rrrgck+s5mFWpRuTphZvqVLUbbfkC26Z7OrYKuGx0hpKk6jF9EkeKXBT
	 /KuIOIgCMIZG04Wh0zqRTuRSbwjaennOh80YN/Sr7l+TS135zFEWGRWi7M2x4e2WPvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914967;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6BSwXqXB8V5vJSPL84hJk1Siibr7tgNkR0HK7gH+6kg=;
	b=nFoqi6xI3wyW7xJ3SmsV1NUwKmVP2IIu5TuGpyb41ASgvLWgZI2G+XSQLNSX+GTNNvhS
	 OrAIlPr67oGkfK/D3MRYCW/YWaWLfXPYDkJY/6VaQ8V0KyL3zfcWLTE1HmlfDVecdpAdH
	 rRfanBlfKkfVxKCPlAIiOnrPM7PemjeEDm2eZeY7PrlG8p1cN5wdUzdyPe3s90nbrbCoK
	 dBktwZN0vRqJLGMveH4/TqgV2r+ENUPrFq8kwyEVz2ys9gvc395zPs3ppcHbaZfMlEmRO
	 nnfiBNkFve7Dt0AtI8sw01dFYAclttEmwbT55W77z8rQTvxpGraov6fPwy37lhPGaAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b="ib8qK2//";
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B30606A31C;
	Tue, 17 Nov 2026 11:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44B30606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=ib8qK2//
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1794914958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6BSwXqXB8V5vJSPL84hJk1Siibr7tgNkR0HK7gH+6kg=;
	b=ib8qK2//wJFgMSymeLybqRfm6ds2hqP5UhTWoeDk71IZ1W41QlVOcxfAsZIxRABvkFNwZk
	RjqhKrGbrfq1iVJnCPpimLAoZJq59OfgJSgjsEo7kdlRQp+zzAK5Uze1tFzje10b/osYqG
	apJAzGZ3/QSo2V+te1whIIM7IY3vKxM=
To: sparclinux@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] sparc64: Read qemu,hwcap-list from the OF cpu node on sun4u
Date: Tue, 17 Nov 2026 12:29:14 +0100
Message-ID: <20261117112914.2300417-1-stian@itx.no>
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
---
The QEMU side is in master for 11.2: commit a1eb9a1720 ("hw/sparc64:
Pass hwcap-list to OpenBIOS via fw_cfg"). The OpenBIOS side is on the
OpenBIOS list:
https://mail.coreboot.org/archives/list/openbios@openbios.org/thread/3XVXVLHWT2T63IYWR67WPOHFSJGLP3NP/
Until QEMU ships an OpenBIOS with it, nvramrc can set the property.
This runs the crypto KUnit tests on the sparc64 code with QEMU master:

NV='" /SUNW,UltraSPARC-IIi" find-device " vis" encode-string " vis2" encode-string encode+ " vis3" encode-string encode+ " aes" encode-string encode+ " sha1" encode-string encode+ " sha256" encode-string encode+ " sha512" encode-string encode+ " crc32c" encode-string encode+ " qemu,hwcap-list" property device-end'
./tools/testing/kunit/kunit.py run --arch=sparc64 \
	--kunitconfig=lib/crypto/.kunitconfig \
	--kunitconfig=lib/crc/.kunitconfig \
	--qemu_args='-cpu TI-UltraSparc-IIi,+vis3,+crypto' \
	--qemu_args='-prom-env use-nvramrc?=true' \
	--qemu_args="-prom-env 'nvramrc=$NV'"

The sparc64 crypto drivers load and the KUnit suites pass. Without
+crypto the CPU caps are unchanged. Once a QEMU release has the
OpenBIOS side, kunit's sparc64 config could pass +crypto. Older QEMU
rejects that flag.

With +crypto, the self-tests of ecb-, cbc- and ctr-aes-sparc64 fail.
The glue keeps the AES round keys in FP registers across
skcipher_walk_done(). On sun4u, the memcpy there uses VIS and
overwrites them. No real sun4u CPU has the crypto opcodes, so this
only shows up under QEMU.

Moving sparc's ECB, CBC and CTR into lib/crypto, as for riscv and x86,
would fix it. Eric, is that something you plan to do?

 arch/sparc/kernel/setup_64.c | 63 ++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b47..87e7b1bf4aeca 100644
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
@@ -507,11 +492,53 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
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
@@ -549,6 +576,8 @@ static void __init init_sparc64_elf_hwcap(void)
 	cap |= (AV_SPARC_MUL32 | AV_SPARC_DIV32 | AV_SPARC_V8PLUS);
 
 	mdesc_caps = mdesc_cpu_hwcap_list();
+	if (!mdesc_caps)
+		mdesc_caps = of_cpu_hwcap_list();
 	if (!mdesc_caps) {
 		if (tlb_type == spitfire)
 			cap |= AV_SPARC_VIS;
-- 
2.43.0

