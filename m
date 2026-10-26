Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043571;
	b=uaNHwajtRzfwK6enSYQ0wDAFgvZcGUl/XkztY0/QbU65/tzh/WR/RGQ1DLGCGV3Ok4jq
	 yKkM1d8wNiwIANaxB4NaQUfjD+Z54Iu7X7Mfl8NTMwu0C/HNwMEBO7xN7mzxftmiVdO4s
	 JH6cKhJ/qUAYJgQdpXrQNNo+uYY/jwqkn/Q6gAkLaq2S853rKyxM/BI8gjeMmSu40sp3z
	 aznGgyZu4vqdG1heIuIPowuHFIpdqfLefkYG5qdvlxyY6sIKOUx7D8LWK1dvGWoliCdhr
	 6xOSW9I8qzrcKw6o01yS/ygyYPMZwAKH4Sg18YnYgmaESaPd2Ex2ZrNbmsgh/MmUX0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043571;
	h=Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0HmOKso3yY8bbyVDSE8ZwGDm/69YbXC4JrNFPnj1s+A=;
	b=N+MtUTyxbuMCH7erbCyRO1ecsnsCzqCG+1/ypS/E2YPcjM/aUDs4/Lz909PjcwqPcerD
	 W+spiUP3y4v9PyGYIqRSbOgvPywhThPuIDyynxNKJd5zFshdUy9CeXh9NQ3Xqko+0dWkn
	 nO9f/FO2zYLTMTN1nXwt5ywxGaR0b4LE2dhZAdv57YWTaimMOR/k7d/SLrLH+Kc+XRr+i
	 onK8+qftONYbElVo6XNHRgFDXrMlEaZsswVXIihbbGCCOJy+Q45GCm34XC1SYznqM14eB
	 ugL19e4G5rPK8pk83vAJ8yJsqhwsF0NsFL1+h1fh3dWwkZSh7dkNDXwG3RkEBWuufdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C6606A31D
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 65534)
	id 4E6151015FBA02; Mon, 26 Oct 2026 20:39:29 +0100 (CET)
X-Spam-Level: 
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:202:600a::a4])
	by a3.inai.de (Postfix) with ESMTP id 2529A1015FBA01
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 20:39:29 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: sparclinux@vger.kernel.org
Subject: [PATCH] sparc: sysfs cache topology information on sun4u (tryout)
Date: Mon, 26 Oct 2026 20:39:26 +0100
Message-ID: <20261026193929.20679-1-jengelh@inai.de>
X-Mailer: git-send-email 2.56.0
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

This is a patch coded up to utilize cacheinfo API for sun4u
as well. Due to lack of hardware, I have *NOT* tried this on
anything, not even qemu. But it does compile at least.

Reads out all the qemu OpenBIOS properties that were missed
before, and would also do this on sparc32 (also missed by Linux
before).
---
 arch/sparc/kernel/prom_common.c | 149 +++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 34f3b2650547..0a5a49fdfc98 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -114,13 +114,159 @@ int of_find_in_proplist(const char *list, const char *match, int len)
 }
 EXPORT_SYMBOL(of_find_in_proplist);
 
+static int of_init_cache_level(unsigned int cpuid)
+{
+	static const char *const l1_obp_names[] = {
+		"dcache-size", "icache-size", "l1-dcache-size", "l1-icache-size"
+	};
+	static const char *const l2_obp_names[] = {
+		"ecache-size", "l2-cache-size",
+	};
+	struct device_node *devn = of_find_node_by_cpuid(cpuid);
+	struct cpu_cacheinfo *ci;
+
+	if (devn == NULL)
+		return 0;
+
+	ci = get_cpu_cacheinfo(cpuid);
+	for (unsigned int i = 0; i < ARRAY_SIZE(l1_obp_names); ++i) {
+		if (!of_property_present(devn, l1_obp_names[i]))
+			continue;
+		ci->num_levels = 1;
+		++ci->num_leaves;
+	}
+
+	/*
+	 * devn might be a core. Try going upwards up to two levels to find
+	 * a potential node for the socket, identified by "portid" /
+	 * "upa-portid" presence, to find the properties for the L2.
+	 */
+	for (unsigned int j = 0; j < 2; ++j) {
+		for (unsigned int i = 0; i < ARRAY_SIZE(l2_obp_names); ++i) {
+			if (of_property_present(devn, l2_obp_names[i])) {
+				ci->num_levels = 2;
+				++ci->num_leaves;
+				return 0;
+			}
+		}
+
+		if (!of_property_present(devn, "cpuid"))
+			break;
+		devn = devn->parent;
+		if (devn == NULL || of_property_present(devn, "upa-portid") ||
+		    of_property_present(devn, "portid"))
+			break;
+	}
+	return 0;
+}
+
+static void of_set_leaf(struct cacheinfo *leaf, struct device_node *devn,
+    unsigned int level, unsigned int type, unsigned int size,
+    const char *ls, const char *ns, const char *as)
+{
+	leaf->fw_token = (void *)(uintptr_t)devn->phandle;
+	leaf->level = level;
+	leaf->type = type;
+	leaf->size = size;
+	if (ls != NULL)
+		leaf->coherency_line_size = of_getintprop_default(devn, ls, 0);
+	if (ns != NULL)
+		leaf->number_of_sets = of_getintprop_default(devn, ns, 0);
+	if (as != NULL)
+		leaf->ways_of_associativity = of_getintprop_default(devn, as, 0);
+}
+
+static int of_populate_cache_leaves(unsigned int cpuid)
+{
+	struct device_node *devn = of_find_node_by_cpuid(cpuid);
+	struct cpu_cacheinfo *ci;
+	unsigned int npop = 0;
+	int size;
+
+	if (devn == NULL)
+		return 0;
+
+	ci = get_cpu_cacheinfo(cpuid);
+	size = of_getintprop_default(devn, "l1-icache-size", -1);
+	if (size != -1) {
+		/* Property typical for Spitfire systems */
+		if (npop >= ci->num_leaves)
+			return -ELOOP;
+		of_set_leaf(&ci->info_list[npop++], devn, 1, CACHE_TYPE_INST,
+			    size, "l1-icache-line-size", NULL, NULL);
+	}
+
+	size = of_getintprop_default(devn, "icache-size", -1);
+	if (size != -1) {
+		/* Property used in e.g. OpenBIOS */
+		if (npop >= ci->num_leaves)
+			return -ELOOP;
+		of_set_leaf(&ci->info_list[npop++], devn, 1, CACHE_TYPE_INST,
+			    size, "icache-line-size", "icache-nlines",
+			    "icache-associativity");
+	}
+
+	size = of_getintprop_default(devn, "l1-dcache-size", -1);
+	if (size != -1) {
+		if (npop >= ci->num_leaves)
+			return -ELOOP;
+		of_set_leaf(&ci->info_list[npop++], devn, 1, CACHE_TYPE_DATA,
+			    size, "l1-dcache-line-size", NULL, NULL);
+	}
+
+	size = of_getintprop_default(devn, "dcache-size", -1);
+	if (size != -1) {
+		if (npop >= ci->num_leaves)
+			return -ELOOP;
+		of_set_leaf(&ci->info_list[npop++], devn, 1, CACHE_TYPE_DATA,
+			    size, "dcache-line-size", "dcache-nlines",
+			    "dcache-associativity");
+	}
+
+	for (unsigned int i = 0; i < 2; ++i) {
+		size = of_getintprop_default(devn, "l2-cache-size", -1);
+		if (size != -1) {
+			if (npop >= ci->num_leaves)
+				return -ELOOP;
+			of_set_leaf(&ci->info_list[npop++], devn, 2,
+				    CACHE_TYPE_UNIFIED, size,
+				    "l2-cache-line-size", NULL, NULL);
+			break;
+		}
+
+		size = of_getintprop_default(devn, "ecache-size", -1);
+		if (size != -1) {
+			if (npop >= ci->num_leaves)
+				return -ELOOP;
+			of_set_leaf(&ci->info_list[npop++], devn, 2,
+				    CACHE_TYPE_UNIFIED, size,
+				    "ecache-line-size", "ecache-nlines",
+				    "ecache-associativity");
+			break;
+		}
+
+		/* Upwards-walking logic follows */
+		if (!of_property_present(devn, "cpuid"))
+			break;
+		devn = devn->parent;
+		if (devn == NULL || of_property_present(devn, "upa-portid") ||
+		    of_property_present(devn, "portid"))
+			break;
+	}
+	return 0;
+}
+
 int init_cache_level(unsigned int cpuid)
 {
 #ifdef CONFIG_SPARC64
 	if (tlb_type == hypervisor)
 		return mdesc_cache_walk(cpuid, false);
+		/*
+		 * MDESC systems do not have the OF properties for caches,
+		 * so no point looking for them there.
+		 */
 #endif
-	return -ENOENT;
+	return of_init_cache_level(cpuid);
 }
 
 int populate_cache_leaves(unsigned int cpuid)
@@ -138,6 +284,7 @@ int populate_cache_leaves(unsigned int cpuid)
 		break;
 #endif
 	default:
+		ret = of_populate_cache_leaves(cpuid);
 		break;
 	}
 	if (ret == -ELOOP)
-- 
2.56.0

