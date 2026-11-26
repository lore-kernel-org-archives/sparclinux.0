Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685497;
	b=ZZpgX4qw/ufx1dPxKLyX9aMSR/dSsyXTvuI5ibOTTF5TuNuB1NKXQLUX/UI4wMBuwnF6
	 0l/uhgakJalUwwprh+9UNIBn7Nu+x6svMRSNz5jXh59VxelaMz4mpGA7L8CZVPwJHim8N
	 p0+1oDJG/V62nHjfql9Lia+4OfIhSETpAXNWI5Rn15037FcYlumxrn0bsTctY0AbIoygq
	 w9NV6aBhHmnzS5/JkqC4IkxaFmaqHlkvUt0YiZq9MzmaCKL18VIAm1JNHY7BhMd/Ck2+A
	 SSRcXabSuUpLRRAXJMUjLH0WTkgg5fqcsc3R3PFoDAJqMltVKlh/egsav/lV0FHqm2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gX0OFpBIYe/qacRDrt/Sy4hgzQEEA9llCw0+rwuqWao=;
	b=bby1KcK1xHwsgVz7gpmHugUrmPCqnyn3P584aYemmorOB2vviRf5nxKUIHf+/CWPINiI
	 l7B7EVYmq0jHMTqDH0iQKiRl25y24uN/s6ea5YvTuZynG9GMOgYCEp1f//ctpByrqu9zw
	 kCZOLKOmuNyUBOsfrHKn7auYhZ+4PwOvGXoFpB26Oc4LZwIV/M5Z0EQDnLSzZyn/Fkr5P
	 1oL2tgp4cPkZUjvkIWe4BQ+W3fqj0sQOa/qOD1G8vCM919/BwRUI9Pqjz4dlQufkjru4S
	 6tm8If68he72PkU9BDtOTB6aRvEQsoHX4MO7QWW9500j+nPangQr/FPtYw5KeQrOX3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cuXSBc4y;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC9606A681
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AFC9606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cuXSBc4y
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c516a192844so681699366b.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685495; x=1796290295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gX0OFpBIYe/qacRDrt/Sy4hgzQEEA9llCw0+rwuqWao=;
        b=cuXSBc4ymy/1FhE7czqgxVhL2pz1j2KhS8v2+IOR5yIiOftYpCI2D+9Q1H96fi7KJX
         SsJPPCRLSl1T+niMFQYhKgowEjPKlquCqfmnlEH2nrhO4CtJo954Qao0+8g0f/K5HEdA
         XT5hZccMWcWoAC1VX0r9kRTnUrcHgZxJ2qk6IJcPjrjXcEFSAwW3/N51vu6UZ48oHjh+
         VvF96Yt9Bujv3mxpDBbgLYBMcdaXYWrGQl34eWz7u6nea8TbBAogPpGXxppnRtUtJ1/H
         MyMPlEgKVPCuYEomKbnIHgpb9Abe4c2xFTa/GGAW3Kx8glAyeifAuRUQ7UBw8gozs/fA
         KhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685495; x=1796290295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gX0OFpBIYe/qacRDrt/Sy4hgzQEEA9llCw0+rwuqWao=;
        b=EaOeGWesAe6GlhqthCoQUgpVwOJ6bgV4a9MMeNRikaTW8Dk4o+Nw9RQNluZIGNhIni
         jC3OAJwDbPnHB+jffdyNUesMIbGA4c4Z0M+ZJvkvqxulmP4YlPcq9j3RhcVH1htFV4Sa
         0wDVF/So1uBuOQomIzSRPVdHpXTDUjUvqhH3AydBOdU5ywMvhrAe+k6pAiGXtykgKM5v
         xxm/2srLTCS78UB12yiRj2ZP7+CKrj0j+KlS8LBp5AR4jCadFTDF5n9H57bya6twYik3
         uMzmQJwSEf7jOreeI12scr+XezkgGgdI2tYwGarKU5Okh8RL0Cg5N2T3Tpbgv2g4RU9f
         DOUw==
X-Forwarded-Encrypted: i=1; AL+hErEbIhGsqjFnclOY3yzRLCZjfezf5NwJpWn0AviefsYB1WTtyzDxW/PWxi5r4uNnoU8dJ5oTAIgJ7jw6@vger.kernel.org
X-Gm-Message-State: APuU4Z+XEWDMVaigBB0sHVahKYqoIfzEKzVkVOJeEF6VaNIp6nk7oT6O
	ALDV3jxf0GOuGMuBeYcjntqSibk/lTJVZGHt7O3eY972r1+aYPE0xvMK
X-Gm-Gg: AZFdTZd0kuiQEWrad9MQp5Dda8151gMxvll+4GfJK0HS3+w445TKNPNg+1kHSd9V1ry
	DFvOA/996qA+6zONzk7B/yq+hTxPr9hnIqOF1AoL85406ahX1JxA2NK6V8c1UIF03KGGwaUNcLJ
	JKqX00SUvIzCZfg902WAejj7aQUO8oGe7FtAd23U5Rsn3WmanBY81fhTRvGkD2KQQfAJKfImtjt
	w66PW4A9Ora15KULAskWdtcxmbKxBugDEs5lwJHlOmvhhYprWFAPbCdFowhuqyzoTA15PcK7E2T
	g1jwK2lajHXXnkuAJS1JFUGM6sEAfjA7sTucdcijGLkz1VsNq7gdnFiWZJ8EMrTAMdIMrao0nAi
	xdICLn7Ry64kahjnejKgpfvRmBHSX03RkpIU4Vk74zXKGDa/3HSjm9AKzBscJ0PEXZhZK0OBinu
	OKbr51BJ5GGcNIFRwPQGI0RGI+/Bz4+vZatVUXSj+Wkvgy+QIAdSwdvnxHPznuX99HZj0rJxynN
	75W6h0jOOMHYfkxvUHJ9Y/R8pi47kYIlIR7mNCh/5/TTxva4HuJ0EsE0IXrWb8qOGTfiWIDLqNn
	9rC9fqWl62IdG1qFPChYbgnvu+oIyn31itfbRBuW4qAXS23CW5sdjdKel0VTUn1iaYQOLr8=
X-Received: by 2002:a17:907:3e92:b0:c51:9ab4:393c with SMTP id a640c23a62f3a-c519ab43c77mr662842566b.32.1795685495308;
        Thu, 26 Nov 2026 01:31:35 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:34 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 16/18] sparc32,leon: use the upper SDRAM on the GR-LEON4-ITX
Date: Thu, 26 Nov 2026 10:30:21 +0100
Message-ID: <20261126093106.1345825-17-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
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

The factory PROM reports only 192 MiB minus 8 KiB on this 256 MiB
board. Match the board, PROM map, DDR2 geometry and active scanout
before registering the unused upper ranges. Honor an explicit mem=
limit.

Keep the PROM and 2 MiB at the framebuffer base out of the allocator.
The latter accommodates grvga's 800x600 RGB565 double buffer. Claim
the adjacent RAM before adding it so an oversized fixed framebuffer
cannot overlap an allocated page.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/leon.h   |  1 +
 arch/sparc/kernel/leon_legacy.c | 56 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/setup_32.c    |  2 ++
 3 files changed, 59 insertions(+)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 9e51f1fb70fd..733394efe0eb 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -227,6 +227,7 @@ void leon_update_virq_handling(unsigned int virq,
 extern bool leon_gr_leon4_itx;
 void leon_init_timers(void);
 bool leon_legacy_is_itx(void);
+void leon_legacy_add_highmem(void);
 void leon_node_init(struct device_node *dp, struct device_node ***nextp);
 void init_leon(void);
 void poke_leonsparc(void);
diff --git a/arch/sparc/kernel/leon_legacy.c b/arch/sparc/kernel/leon_legacy.c
index d6c9efe59f42..03d3120797f0 100644
--- a/arch/sparc/kernel/leon_legacy.c
+++ b/arch/sparc/kernel/leon_legacy.c
@@ -5,10 +5,14 @@
  * Build the AMBA device tree omitted by the factory LEON U-Boot.
  */
 
+#include <linux/bitfield.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_pdt.h>
+#include <linux/sizes.h>
 #include <linux/string.h>
 
 #include <asm/leon.h>
@@ -22,6 +26,13 @@
 #define LEGACY_AHB_SLOTS 64
 #define LEGACY_APB_SLOTS 16
 
+#define ITX_DDR_BASE		0x40000000
+#define ITX_PROM_END		0x4c000000
+#define ITX_FB_BASE		0x4d000000
+#define ITX_DDR_END		0x50000000
+#define ITX_DDR2CFG1		0xffe00100
+#define ITX_GRVGA		0xc0800000
+
 struct legacy_bus {
 	u32 area;
 	u32 freq;
@@ -44,6 +55,51 @@ bool __init leon_legacy_is_itx(void)
 	return prom_leon_legacy && leon_gr_leon4_itx;
 }
 
+/* grvga may request a fixed framebuffer with devm_request_mem_region(). */
+static struct resource itx_highmem[] = {
+	DEFINE_RES_NAMED(ITX_PROM_END, ITX_FB_BASE - ITX_PROM_END, "System RAM",
+			 IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY),
+	DEFINE_RES_NAMED(ITX_FB_BASE + SZ_2M, ITX_DDR_END - ITX_FB_BASE - SZ_2M,
+			 "System RAM", IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY),
+};
+
+void __init leon_legacy_add_highmem(void)
+{
+	struct resource *res;
+	unsigned int i;
+
+	/* The factory PROM reports only the first 192 MiB minus 8 KiB. */
+	if (!leon_legacy_is_itx() || memblock.memory.cnt != 1 ||
+	    memblock_start_of_DRAM() != ITX_DDR_BASE ||
+	    memblock_end_of_DRAM() != ITX_PROM_END - SZ_8K)
+		return;
+
+	/* DDR2CFG1 bank size code 5 selects 256 MiB per chip select. */
+	if (FIELD_GET(GENMASK(25, 23), legacy_read(ITX_DDR2CFG1)) != 5)
+		return;
+
+	/* Match U-Boot's 800x600 RGB565 scanout before reusing the rest. */
+	if (legacy_read(ITX_GRVGA + 0x14) != ITX_FB_BASE ||
+	    legacy_read(ITX_GRVGA + 0x04) != ((599 << 16) | 799) ||
+	    FIELD_GET(GENMASK(5, 4), legacy_read(ITX_GRVGA)) != 2)
+		return;
+
+	/* Leave room for the factory scanout and grvga's double buffer. */
+	for (i = 0; i < ARRAY_SIZE(itx_highmem); i++) {
+		res = &itx_highmem[i];
+		if (request_resource(&iomem_resource, res)) {
+			pr_warn("LEON: GR-LEON4-ITX high memory %pr is busy\n", res);
+			continue;
+		}
+		if (memblock_add(res->start, resource_size(res))) {
+			release_resource(res);
+			pr_warn("LEON: failed to add GR-LEON4-ITX high memory %pr\n", res);
+			continue;
+		}
+		pr_info("LEON: added GR-LEON4-ITX high memory %pr\n", res);
+	}
+}
+
 static bool __init legacy_is(u32 id, unsigned int device)
 {
 	return (id >> 24) == VENDOR_GAISLER &&
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c84ac2f1ad15..20c8914cb965 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -313,6 +313,8 @@ static void __init setup_memory(void)
 
 	memblock_set_bottom_up(true);
 	memblock_allow_resize();
+	if (IS_ENABLED(CONFIG_SPARC_LEON) && !cmdline_memory_size)
+		leon_legacy_add_highmem();
 
 	phys_base = ram_base;
 	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
-- 
2.43.0

