Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296782;
	b=xs0lelrjkt7pGzL9f1frD9RTinzSaYnkf8kDU0POEBNECXica+5DrW6Xy/xQ0D8jjuZc
	 VAb7czVxTrsdtbeH0hAe52vX/P8R5xyUQEVSXLphjtOYXyzIctIufrdIl5fQdQtzwRQMu
	 CWtPAgRVEcrBrDxJ0Ym9k4+RBO9eC2/gChs0yE9VELO3vBgl5HNhTNYeEFk7N8JH8lWEC
	 7SWZEw3Q3qDE/GajR1lRdDkVUMc3m48eMoQ6VDXUuxxLmFRhGi/PU73mtUCIwYuLRNx1D
	 GNM+6RvGl7qM5iZ1y1OVZLoEP7W1pMdIzOYkDfxdyfSGiChE8DLSBzz/D8ZU/gm0Q8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296782;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vae+p4T8Zl+Htvwo0CKGb1vRXOY+jKfS6WbpY4tQNKE=;
	b=iqMWcyUdZjyXM2PdyA1BY4FdLx1gkD6sRRhpysdOViiMyE1QMvMdtJYduUDzYYSYJVq+
	 9yRGU7oHsqxxG7m4oAgy05Xg6lpy/0qkNEw0EFS/Sx7XfgdwAzAWIS5X1MOuhKyM+BlHD
	 HJskvyU02duYAkVGQh9BRayNA7u4bw+L8KwZn8Fljm6Bfug+sHC2NBWU4jfo+x9dq2bAl
	 Wn3JtXWp6bPKzaiz+NUtRcqXRB3A67o5afGGjpzUpGQJi7X4VWLfRF6xdq4P1LBwsgx2I
	 ixM7107tjc1b0Mn5VLb97vPL6NTv/cffkWNw8MNSnzklsscMRAwvKtuJVZtvg3Ee6kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=none smtp.mailfrom=a4.inai.de;
	arc=none smtp.remote-ip=144.76.212.148
Received: from a4.inai.de (a4.inai.de [144.76.212.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B02606A31C
	for <sparclinux@vger.kernel.org>; Thu, 29 Oct 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=a4.inai.de
Received: by a4.inai.de (Postfix, from userid 25121)
	id D6952180037271; Mon, 26 Oct 2026 19:10:41 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	unixpro1970@gmail.com,
	stian@itx.no,
	glaubitz@physik.fu-berlin.de
Subject: sparc: sysfs cache topology information for/on sun4u
Date: Mon, 26 Oct 2026 19:01:59 +0100
Message-ID: <20261026181041.20172-1-jengelh@inai.de>
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

This patch goes on top of the just-sent "[PATCH v2] sparc: populate
sysfs cache topology information on sun4v", and is for sun4u.

Due to lack of sun4u hardware, I have *NOT* tested patch (not even in
qemu). It compiles, but it could crash, or not do anything at all,
and may need a developer to sprinkle it ad-hoc with some more printfs
to see what's really going on.

The patch arguably supports all the qemu OpenBIOS properties
(something previously missed AFAICT), and also populates cacheinfo
for sparc32 (also missed).

The real test would be on a multi-core sun4u (i.e. shared caches),
which means UltraSPARC IV and the subsequent line of M-series
chips/machines up to just before the M10.

-- 
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

