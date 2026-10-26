Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043270;
	b=Tvi18BfLqeShk+8/SJJVzCTH8z5u8rMEFvUOeaH3RMIXBTb3HeMwPwWRJWQpRd/szy8z
	 doSB+5eC4RJHyBcRVyOPnmaML5EcVLzz5woaOZeoQSdqu9o6t3/KL+USrTwwAVG5sk5Hl
	 YfMrAUj9sMJ3odVkLQQ04Do98Xwyhx3wGmTX74zE4TUHL0b4yp9gHeJk2T8C6EmqjzFBu
	 zFxUVhvSiOvkCxc2HVFvHH034UNGdjzS6QWtMOqJrWUDiFQzZoExKlNnvnDL782NDuM0l
	 e/zPu5KmqfnctmbsFBS8l7S3ImyAkN28T01xumAVCKM+mZ08jgaR5ZOEljVMQUSLF6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043270;
	h=Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hmHaotTiDmNyuNlGIoDoU9cwbta2H2IkiS0Oy3UU+yA=;
	b=1gQqUrE1K+ebssXoNglqcwnuIJJ8f7SxHOFa1sSdW/LqXVuxnWeIQkioPIQIihDGve7s
	 bYHt6mfpaldISjS5YYwGujX7nAzHiCiYtwsL9d0cIvTtKsH6Xf944aXEE7RDbeSSC3hAk
	 p4VPScZIPTnMtEkxOHghayq86OMKTtk/vmC3jpQUwOg9yHi2BlA0ltRXzeXZbeQxT5EWh
	 CagdT+pCE6sohenqlBxvCRDYDITKAu6idouoBZQ7VjP44h9gkqy8NgekL/ROsPwmdH+rc
	 5HfUJIg3P73SurVyuhulf8AwwQirjS4VYJrOZrJXW4K5YQKpsd264DyAowZM1FUNS1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7E606A31A
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 65534)
	id 1045B101B13B99; Mon, 26 Oct 2026 20:34:22 +0100 (CET)
X-Spam-Level: 
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:202:600a::a4])
	by a3.inai.de (Postfix) with ESMTP id CBE581003FC39F
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 20:34:21 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: sparclinux@vger.kernel.org
Subject: [PATCH] sparc: populate sysfs cache topology information on sun4v
Date: Mon, 26 Oct 2026 20:34:17 +0100
Message-ID: <20261026193421.20404-1-jengelh@inai.de>
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

The SPARC port (arch/sparc/) originally invented its own way of
reporting cache sizes for Linux version 2.6.22, by providing e.g.
/sys/devices/system/cpu/cpu0/l1_icache_size. lscpu (util-linux 2.37)
gained code just to read these SPARC-specific sysfs files.

The Linux kernel gained a generic cacheinfo reporting mechanism
(drivers/base/cacheinfo.c) in v3.19, but arch/sparc's sysfs files
were not unified into it, unfortunately.

Because the SPARC sysfs files convey no information about the shared
nature of caches, lscpu (util-linux 2.42) overreports cache numbers.
For example, on a T5240 machine:

```
Model name:            UltraSparc T2 (Niagara2)
  Thread(s) per core:  4
  Core(s) per socket:  16
  Socket(s):           2
  Flags:               sun4v
Caches (sum of all):
  L1d:                 1 MiB (128 instances)
  L1i:                 2 MiB (128 instances)
  L2:                  512 MiB (128 instances)
```

The SPARC port also lacked reporting L3 caches, present in the
Oracle S3 and Fujitsu SPARC64 XII cores (machines: Oracle T4 and
Fujitsu M12, respectively.)

On a SPARC S7-2:

```
Model name:            SPARC-S7 (Sonoma)
  Thread(s) per core:  8
  Core(s) per socket:  8
  Socket(s):           2
  Flags:               sun4v
Caches (sum of all):
  L1d:                 256 KiB (16 instances)
  L1i:                 256 KiB (16 instances)
  L2:                  2 MiB (8 instances)
```

This patch implements population of the sysfs cacheinfo structures
for sun4v. The proper amount is now reflected in lscpu's output:

```
<<T5240>>
Caches (sum of all):
  L1d:                 128 KiB (16 instances)
  L1i:                 256 KiB (16 instances)
  L2:                  8 MiB (2 instances)

<<S7-2>>
  L1d:                 256 KiB (16 instances)
  L1i:                 256 KiB (16 instances)
  L2d:                 2 MiB (8 instances)
  L2i:                 1 MiB (4 instances)
  L3:                  32 MiB (4 instances)
```
---
 arch/sparc/include/asm/cpudata_64.h |   1 +
 arch/sparc/include/asm/mdesc.h      |   2 +
 arch/sparc/kernel/mdesc.c           | 136 ++++++++++++++++++++++++++++
 arch/sparc/kernel/prom_common.c     |  34 +++++++
 4 files changed, 173 insertions(+)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 056b3c0e7ef9..57b020ba93e0 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -29,6 +29,7 @@ typedef struct {
 	unsigned short	core_id;
 	unsigned short  max_cache_id;	/* groupings of highest shared cache */
 	signed short	proc_id;	/* strand (aka HW thread) id */
+	u64             mdesc_node;
 } cpuinfo_sparc;
 
 DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
diff --git a/arch/sparc/include/asm/mdesc.h b/arch/sparc/include/asm/mdesc.h
index ec31a06d04cc..71e77641f158 100644
--- a/arch/sparc/include/asm/mdesc.h
+++ b/arch/sparc/include/asm/mdesc.h
@@ -90,6 +90,8 @@ u64 mdesc_get_node(struct mdesc_handle *hp, const char *node_name,
 int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
 			const char *node_name, union md_node_info *node_info);
 
+int mdesc_cache_walk(unsigned int cpuid, bool fill_it);
+
 void mdesc_fill_in_cpu_data(cpumask_t *mask);
 void mdesc_populate_present_mask(cpumask_t *mask);
 void mdesc_get_page_sizes(cpumask_t *mask, unsigned long *pgsz_mask);
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index ecd6c8ae49c7..8b982c6fee11 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -1195,6 +1195,12 @@ static void *fill_in_one_cpu(struct mdesc_handle *hp, u64 mp, int cpuid,
 
 	c = &cpu_data(cpuid);
 	c->clock_tick = *cfreq;
+	/*
+	 * This will help more quickly finding the mdesc node again
+	 * (otherwise we would have to iterate over all cpu nodes
+	 * to locate any one with a given id).
+	 */
+	c->mdesc_node = mp;
 
 	tb = &trap_block[cpuid];
 	get_mondo_data(hp, mp, tb);
@@ -1242,6 +1248,136 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
 	smp_fill_in_sib_core_maps();
 }
 
+/**
+ * At MDESC node @node, analyze forward links to find the @want_target,
+ * and, if @want_type is not %NULL, that it is of the requested type.
+ */
+static u64 mdesc_find_subobject(struct mdesc_handle *mdh, u64 iu_node,
+				const char *want_target, const char *want_type)
+{
+	u64 iter;
+
+	mdesc_for_each_arc(iter, mdh, iu_node, MDESC_ARC_TYPE_FWD) {
+		u64 sub_node = mdesc_arc_target(mdh, iter);
+		const char *sub_name = mdesc_node_name(mdh, sub_node);
+		const char *type_list;
+		int len;
+
+		if (strcmp(sub_name, want_target) != 0)
+			continue;
+		if (want_type == NULL)
+			return sub_node;
+		type_list = mdesc_get_property(mdh, sub_node, "type", &len);
+		if (of_find_in_proplist(type_list, want_type, len))
+			return sub_node;
+	}
+	return -1;
+}
+
+static void mdesc_cache_fill(struct mdesc_handle *mdh, u64 cache_node,
+			     struct cacheinfo *leaf)
+{
+	int type_len;
+	const u64 *level      = mdesc_get_property(mdh, cache_node, "level", NULL);
+	const u64 *size       = mdesc_get_property(mdh, cache_node, "size", NULL);
+	const u64 *line_size  = mdesc_get_property(mdh, cache_node, "line-size", NULL);
+	const u64 *assoc      = mdesc_get_property(mdh, cache_node, "associativity", NULL);
+	const char *type_list = mdesc_get_property(mdh, cache_node, "type", &type_len);
+
+	leaf->fw_token = (void *)(uintptr_t)cache_node;
+	leaf->level = *level;
+	if (type_list != NULL) {
+		bool i = of_find_in_proplist(type_list, "instn", type_len);
+		bool d = of_find_in_proplist(type_list, "data", type_len);
+		if (i && d)
+			leaf->type = CACHE_TYPE_UNIFIED;
+		else if (i)
+			leaf->type = CACHE_TYPE_INST;
+		else if (d)
+			leaf->type = CACHE_TYPE_DATA;
+	}
+	if (size != NULL)
+		leaf->size = *size;
+	if (line_size != NULL)
+		leaf->coherency_line_size = *line_size;
+	if (assoc != NULL)
+		leaf->ways_of_associativity = *assoc;
+	if (leaf->coherency_line_size != 0 && leaf->ways_of_associativity != 0)
+		leaf->number_of_sets = leaf->size / leaf->coherency_line_size /
+				       leaf->ways_of_associativity;
+}
+
+static int mdesc_cache_record(struct mdesc_handle *mdh, u64 cache_node,
+			      unsigned int cpuid, unsigned int *leaf_count,
+			      bool fill_it)
+{
+	struct cpu_cacheinfo *ci;
+	const u64 *level = mdesc_get_property(mdh, cache_node, "level", NULL);
+	u64 iter;
+
+	if (level == NULL)
+		return -ENOENT;
+	ci = get_cpu_cacheinfo(cpuid);
+	if (fill_it) {
+		if (*leaf_count >= ci->num_leaves)
+			return -ELOOP;
+		mdesc_cache_fill(mdh, cache_node,
+				 &ci->info_list[(*leaf_count)++]);
+	} else {
+		++ci->num_leaves;
+		if (ci->num_levels < *level)
+			ci->num_levels = *level;
+	}
+
+	mdesc_for_each_arc(iter, mdh, cache_node, MDESC_ARC_TYPE_FWD) {
+		u64 sub_node = mdesc_arc_target(mdh, iter);
+		const char *sub_name = mdesc_node_name(mdh, sub_node);
+		int ret;
+
+		if (strcmp(sub_name, "cache") != 0)
+			continue;
+		ret = mdesc_cache_record(mdh, sub_node, cpuid,
+					 leaf_count, fill_it);
+		if (ret != 0)
+			return ret;
+	}
+	return 0;
+}
+
+int mdesc_cache_walk(unsigned int cpuid, bool fill_it)
+{
+	/*
+	 * ifetch is where instruction caches are reported under.
+	 * integer is where data cahes are reported under.
+	 *
+	 * The MDESCs of e.g. the SUNW,T5240 and ORCL,SPARC-S7-2 machines
+	 * use "integer". Which machines are using "int"?
+	 */
+	static const char *const unit_kinds[] = {"ifetch", "integer", "int"};
+	unsigned int leaf_count = 0;
+	int ret = 0;
+	struct mdesc_handle *mdh = mdesc_grab();
+
+	if (mdh == NULL)
+		return -ENOENT;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(unit_kinds); ++i) {
+		u64 node = mdesc_find_subobject(mdh, cpu_data(cpuid).mdesc_node,
+						"exec-unit", unit_kinds[i]);
+		if (node == -1)
+			continue;
+		node = mdesc_find_subobject(mdh, node, "cache", NULL);
+		if (node == -1)
+			continue;
+		ret = mdesc_cache_record(mdh, node, cpuid,
+					 &leaf_count, fill_it);
+		if (ret != 0)
+			break;
+	}
+	mdesc_release(mdh);
+	return ret;
+}
+
 /* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc is
  * opened. Hold this reference until /dev/mdesc is closed to ensure
  * mdesc data structure is not released underneath us. Store the
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index d258fd10db01..34f3b2650547 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -11,12 +11,14 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cacheinfo.h>
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_pdt.h>
+#include <asm/mdesc.h>
 #include <asm/prom.h>
 #include <asm/oplib.h>
 
@@ -112,6 +114,38 @@ int of_find_in_proplist(const char *list, const char *match, int len)
 }
 EXPORT_SYMBOL(of_find_in_proplist);
 
+int init_cache_level(unsigned int cpuid)
+{
+#ifdef CONFIG_SPARC64
+	if (tlb_type == hypervisor)
+		return mdesc_cache_walk(cpuid, false);
+#endif
+	return -ENOENT;
+}
+
+int populate_cache_leaves(unsigned int cpuid)
+{
+	/*
+	 * Note that drivers/base/cacheinfo expects leaves to be sorted by
+	 * level, then by index in [inst, data_or_unified]. Code should fill
+	 * in leaves in that order (else, a call to qsort will be needed).
+	 */
+	int ret = -ENOENT;
+	switch (tlb_type) {
+#ifdef CONFIG_SPARC64
+	case hypervisor:
+		ret = mdesc_cache_walk(cpuid, true);
+		break;
+#endif
+	default:
+		break;
+	}
+	if (ret == -ELOOP)
+		pr_err("%s: tried to populate too much. "
+		       "(Programming error, go investigate.)\n", __func__);
+	return ret;
+}
+
 /*
  * SPARC32 and SPARC64's prom_nextprop() do things differently
  * here, despite sharing the same interface.  SPARC32 doesn't fill in 'buf',
-- 
2.56.0

