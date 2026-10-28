Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149270;
	b=B/3MkB4KVfkMfzVeEfwMRJyO4zKFkf2hpghg+8k63yt92Tkmz4Ihn3g6NAAR/3AH8qyr
	 OLS5lpyNueLV7zIShnZkc0nH7TJsU6G0z1HXsEhV3wuS+4Weczsy0pZvr/EhgyecAtlUM
	 5zZC4MexvEbsXpITMz5hcR91QEzR9ALzpba+p4rajYdkMIirCABMSHj1WfxqUDsqd3xKv
	 75xSgAVwwJNsediMEh7YkwCPhNjalNZ2Tj9KGBigFRn1+if5W0HJKDxceZHv1Lq+un+Mw
	 0IQ8hXTz7B6jJLmYYw/wFQV0zm2Acv50rG/zbn8ttz28wvaeIMR1NX+J0PgN67a27vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149270;
	h=Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9VMb/XxOqHiIA1z153Ng4ApO82Y5IDbjJ5huFzFfulQ=;
	b=o3UQbZ2ROkaueU7ufuG9Qg7AaBl0ePcHn4ep/28UMvqYmc+gpCXMd1FhGM2g9w+7g7ig
	 mdzBd2JGiaSuaNwYVsFNhzTD/MKDNvsNsukVqJ6ONQc03azAlqtmvnJPmHM3KAJga+iRI
	 2o1CU/AuLYDkYf9RrVLb1NDA3uFSnr3qI3Px0N4S+IO0Vl7uJkmHEra1ygoC4E5sreRG3
	 B+RKg5cpydfkZQujr9cYBZX4vzHgxp2mdui+gCeJQVvCbwv3cJIptax/G+C0mGr9U2Cgq
	 OWckLx4B1Ptb5TYyTmAr9ATTBk7QNhsfADDU2vym6lFpGyAUeBXGXIz0t7cxE1m2m6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B5606A31A
	for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 65534)
	id 71E6E1019D1D89; Wed, 28 Oct 2026 02:01:01 +0100 (CET)
X-Spam-Level: 
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:202:600a::a4])
	by a3.inai.de (Postfix) with ESMTP id E28ED10038755A;
	Wed, 28 Oct 2026 02:01:00 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	stian@itx.no,
	unixpro1970@gmail.com,
	glaubitz@physik.fu-berlin.de
Subject: [PATCH v3] sparc: populate sysfs cache topology information on sun4v
Date: Wed, 28 Oct 2026 02:00:22 +0100
Message-ID: <20261028010100.24792-1-jengelh@inai.de>
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
Oracle S3 and Fujitsu SPARC64 XII cores (machines: Oracle T4
onwards and Fujitsu M12, respectively.)

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
v3:
//current
* Resolved the issue that only the first cache of any integer unit
  was looked at.
* Resolved the issue that only the first integer unit of any strand
  was looked at.
* Resolved the issue that only integer units were considered for caches.
* No more duplicated cache entries under
  /sys/devices/system/cpu/cpu0/cache/indexN.
* No longer keep unstable MDESC node ids around past their lifetime.

v2:
//Message-ID: <20261026193421.20404-1-jengelh@inai.de>
* Rewalk MDESC rather than sourcing cache info from struct cpuinfo_sparc.
* Support L3 caches found on SPARC T4 and later machine models.

v1:
//Message-ID: <20261018222723.43442-1-jengelh@inai.de>

 arch/sparc/include/asm/cpudata_64.h |   1 +
 arch/sparc/include/asm/mdesc.h      |   2 +
 arch/sparc/kernel/mdesc.c           | 215 ++++++++++++++++++++++++++++
 arch/sparc/kernel/prom_common.c     |  53 +++++++
 4 files changed, 271 insertions(+)

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
index ecd6c8ae49c7..0e400b451b4b 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
 #include <linux/memblock.h>
+#include <linux/cacheinfo.h>
 #include <linux/export.h>
 #include <linux/refcount.h>
 
@@ -1242,6 +1243,220 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
 	smp_fill_in_sib_core_maps();
 }
 
+/**
+ * Return the MDESC node for a "cpu" object whose "id" property
+ * matches @cpuid.
+ */
+static u64 mdesc_find_cpu(struct mdesc_handle *mdh, int cpuid)
+{
+	u64 iter;
+	mdesc_for_each_node_by_name(mdh, iter, "cpu") {
+		const u64 *id = mdesc_get_property(mdh, iter, "id", NULL);
+		if (id != NULL && *id == cpuid)
+			return iter;
+	}
+	return MDESC_NODE_NULL;
+}
+
+/**
+ * Obtain the properties of a given MDESC cache object node and fill in the
+ * Linux representation (struct cacheinfo) for it.
+ */
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
+	/*
+	 * fw_token is only temporary. It will be cleared again before the
+	 * MDESC is unpinned.
+	 */
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
+/**
+ * Populate the sharedness bitmap of a given struct cacheinfo by walking up the
+ * cache chain again and finding all CPUs.
+ */
+static void mdesc_cache_set_shared(struct mdesc_handle *mdh, u64 cache_node,
+				   struct cacheinfo *leaf)
+{
+	unsigned int maxcpus = num_possible_cpus();
+	u64 sup_iter, cpu_iter;
+
+	mdesc_for_each_arc(sup_iter, mdh, cache_node, MDESC_ARC_TYPE_BACK) {
+		u64 sup_node = mdesc_arc_target(mdh, sup_iter);
+		const char *tg_name = mdesc_node_name(mdh, sup_node);
+
+		if (strcmp(tg_name, "cache") == 0)
+			mdesc_cache_set_shared(mdh, sup_node, leaf);
+		if (strcmp(tg_name, "exec-unit") != 0)
+			continue;
+
+		mdesc_for_each_arc(cpu_iter, mdh, sup_node, MDESC_ARC_TYPE_BACK) {
+			u64 cpu_node = mdesc_arc_target(mdh, cpu_iter);
+			tg_name = mdesc_node_name(mdh, cpu_node);
+
+			if (strcmp(tg_name, "cpu") != 0)
+				continue;
+			const u64 *id = mdesc_get_property(mdh, cpu_node, "id", NULL);
+			if (id == NULL)
+				continue;
+			if (id != NULL && *id < maxcpus)
+				cpumask_set_cpu(*id, &leaf->shared_cpu_map);
+		}
+	}
+}
+
+static bool seen_cache(const struct cacheinfo *leaf, size_t n, u64 node)
+{
+	while (n-- > 0)
+		if ((uintptr_t)leaf[n].fw_token == node)
+			return true;
+	return false;
+}
+
+/**
+ * For a given MDESC "cache" object node, copy properties, and recursively
+ * search for lower-level caches.
+ */
+static int mdesc_cache_record(struct mdesc_handle *mdh, u64 cache_node,
+			      unsigned int cpuid, unsigned int *leaf_count,
+			      bool fill_it)
+{
+	const u64 *level = mdesc_get_property(mdh, cache_node, "level", NULL);
+	struct cpu_cacheinfo *cc;
+	u64 iter;
+
+	if (level == NULL)
+		return -ENOENT;
+	cc = get_cpu_cacheinfo(cpuid);
+	if (fill_it) {
+		if (*leaf_count >= cc->num_leaves) {
+			/*
+			 * 1. Sudden MDESC change between init_cache_level
+			 * and populate_cache_leaves, or 2. programming
+			 * errors.
+			 */
+			pr_err("%s: tried to populate more cacheinfos than "
+			       "allocated.\n", __func__);
+			return -ELOOP;
+		}
+		if (!seen_cache(cc->info_list, *leaf_count, cache_node)) {
+			struct cacheinfo *ci = &cc->info_list[(*leaf_count)++];
+			mdesc_cache_fill(mdh, cache_node, ci);
+			mdesc_cache_set_shared(mdh, cache_node, ci);
+			cc->cpu_map_populated = true;
+		}
+	} else {
+		++cc->num_leaves;
+		if (cc->num_levels < *level)
+			cc->num_levels = *level;
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
+/**
+ * For a given Linux CPU @cpuid (hardware strand), find the corresponding "cpu"
+ * object node in the MDESC, and from there follow pointers to "exec-unit"
+ * object nodes and, subsequently, "cache" object nodes.
+ */
+int mdesc_cache_walk(unsigned int cpuid, bool fill_it)
+{
+	unsigned int leaf_count = 0;
+	struct mdesc_handle *mdh = mdesc_grab();
+	u64 cpu_node, eu_arc;
+	int ret = 0;
+
+	if (mdh == NULL)
+		return -ENOENT;
+
+#ifndef CONFIG_SMP
+	/*
+	 * On UP, cpu_data() has just one entry with index 0, but we want
+	 * the values from the real physical cpu the kernel booted on.
+	 */
+	cpuid = real_hard_smp_processor_id();
+#endif
+
+	cpu_node = mdesc_find_cpu(mdh, cpuid);
+	if (cpu_node == MDESC_NODE_NULL) {
+		mdesc_release(mdh);
+		return -ENOENT;
+	}
+
+	mdesc_for_each_arc(eu_arc, mdh, cpu_node, MDESC_ARC_TYPE_FWD) {
+		u64 cache_arc;
+		u64 eu_node = mdesc_arc_target(mdh, eu_arc);
+		const char *node_name = mdesc_node_name(mdh, eu_node);
+
+		if (strcmp(node_name, "exec-unit") != 0)
+			continue;
+
+		mdesc_for_each_arc(cache_arc, mdh, eu_node, MDESC_ARC_TYPE_FWD) {
+			u64 cache_node = mdesc_arc_target(mdh, cache_arc);
+			node_name = mdesc_node_name(mdh, cache_node);
+			if (strcmp(node_name, "cache") != 0)
+				continue;
+			ret = mdesc_cache_record(mdh, cache_node, cpuid,
+						 &leaf_count, fill_it);
+			if (ret != 0)
+				goto out;
+		}
+	}
+
+	if (fill_it) {
+		/* Reduce count to actually populated slots. */
+		struct cpu_cacheinfo *cc = get_cpu_cacheinfo(cpuid);
+		cc->num_leaves = leaf_count;
+
+		/* We have the sharedness bitmaps and don't need fw_token. */
+		for (size_t i = 0; i < cc->num_leaves; ++i)
+			cc->info_list[i].fw_token = NULL;
+	}
+ out:
+	mdesc_release(mdh);
+	return ret;
+}
+
 /* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc is
  * opened. Hold this reference until /dev/mdesc is closed to ensure
  * mdesc data structure is not released underneath us. Store the
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index d258fd10db01..808dc044514f 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -11,12 +11,15 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cacheinfo.h>
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_pdt.h>
+#include <linux/sort.h>
+#include <asm/mdesc.h>
 #include <asm/prom.h>
 #include <asm/oplib.h>
 
@@ -112,6 +115,56 @@ int of_find_in_proplist(const char *list, const char *match, int len)
 }
 EXPORT_SYMBOL(of_find_in_proplist);
 
+/**
+ * Called from from drivers/base/cacheinfo.c meant to set
+ * cpu_cacheinfo::num_leaves for allocation purposes.
+ */
+int init_cache_level(unsigned int cpuid)
+{
+#ifdef CONFIG_SPARC64
+	if (tlb_type == hypervisor)
+		return mdesc_cache_walk(cpuid, false);
+#endif
+	return -ENOENT;
+}
+
+static int cache_leaf_compare(const void *va, const void *vb)
+{
+	const struct cacheinfo *a = va, *b = vb;
+	int r = cmp_int(a->level, b->level);
+	return r != 0 ? r : cmp_int(a->type, b->type);
+}
+
+static void cache_leaf_swap(void *va, void *vb, int size)
+{
+	struct cacheinfo c;
+	memcpy(&c, va, size);
+	memcpy(va, vb, size);
+	memcpy(vb, &c, size);
+}
+
+int populate_cache_leaves(unsigned int cpuid)
+{
+	int ret;
+#ifdef CONFIG_SPARC64
+	if (tlb_type == hypervisor) {
+		ret = mdesc_cache_walk(cpuid, true);
+	}
+	else
+#endif
+	{
+		/* Room to put the call for an OF-based cache walk here */
+		ret = -ENOENT;
+	}
+	if (ret == 0) {
+		/* cacheinfo.c wants the last item to be the farthest cache */
+		struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpuid);
+		sort(ci->info_list, ci->num_leaves, sizeof(struct cacheinfo),
+		     cache_leaf_compare, cache_leaf_swap);
+	}
+	return ret;
+}
+
 /*
  * SPARC32 and SPARC64's prom_nextprop() do things differently
  * here, despite sharing the same interface.  SPARC32 doesn't fill in 'buf',
-- 
2.56.0
