Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDD35C692;
	Sun, 18 Oct 2026 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362448; cv=none; b=dFxyZRtirAuXcKkw9Bw7Mf5KGGGgzSmrzeQZeZTvRF+u0CaRtWTi5B+LjMMeXs/VToZZBsxpvAkHV0NgCFvH9IrR3RTsEj0oKT9HUY9fjgH+cUh7jyVNfvyr9VcZ457WCeBERqOOh451oymuN42+dzwAfky33K1qzLs0OvipVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362448; c=relaxed/simple;
	bh=2NVOb7z3F4kDcm+Z2BiiTLIkK+yMkKv/C+dtySFMK2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJOTYFvc9aHb7wgqWfP4R9zoI5P+p8zSJv8uF91j9mOdJ6sYSmhg7HS0X5l7GlRQRFHriNdLqdh/W15EZERo7ETOwIkH/bfibjw5pQAQ7ro8v335vwOOgwVOeMqi9shah+P1/x3NbO+6N4AuJTVsAgKd9urU65d3jqQhlgAm+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 65534)
	id 3C97C1003BF4B4; Mon, 19 Oct 2026 00:27:24 +0200 (CEST)
X-Spam-Level: 
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:202:600a::a4])
	by a3.inai.de (Postfix) with ESMTP id ECEE51003BF4B4;
	Mon, 19 Oct 2026 00:27:23 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] sparc: populate sysfs cache topology information on sun4v
Date: Mon, 19 Oct 2026 00:27:23 +0200
Message-ID: <20261018222723.43442-1-jengelh@inai.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPARC port does not publish any cache topology information. The
lscpu utility therefore falls back to assuming the published cache
sizes are for unshared caches, and as a result, reports way more
cache than there really is present in the system. On a T5240 machine:

```
$ lscpu
Architecture:          sparc64
  CPU op-mode(s):      32-bit, 64-bit
  Byte Order:          Big Endian
CPU(s):                128
  On-line CPU(s) list: 0-127
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

This patch implements population of the sysfs cacheinfo structures
for sun4v (systems with mdesc). The proper amount is now reflected in
lscpu's output:

```
Caches (sum of all):
  L1d:                 128 KiB (16 instances)
  L1i:                 256 KiB (16 instances)
  L2:                  8 MiB (2 instances)
```

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 arch/sparc/include/asm/cpudata_64.h |  8 +++-
 arch/sparc/kernel/mdesc.c           | 61 +++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 056b3c0e7ef9..e28b841ffe23 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -18,13 +18,19 @@ typedef struct {
 	unsigned int	irq0_irqs;
 	unsigned int	__pad2;
 
-	/* Dcache line 2, rarely used */
+	/* Dcache line 2+3, rarely used */
 	unsigned int	dcache_size;
 	unsigned int	dcache_line_size;
+	unsigned int	dcache_assoc;
+	unsigned int	dcache_id;
 	unsigned int	icache_size;
 	unsigned int	icache_line_size;
+	unsigned int	icache_assoc;
+	unsigned int	icache_id;
 	unsigned int	ecache_size;
 	unsigned int	ecache_line_size;
+	unsigned int	ecache_assoc;
+	unsigned int	ecache_id;
 	unsigned short	sock_id;	/* physical package */
 	unsigned short	core_id;
 	unsigned short  max_cache_id;	/* groupings of highest shared cache */
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 23b51a32e96e..029d9d812074 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -818,6 +818,7 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struct mdesc_handle *hp, u64 mp)
 	const u64 *level = mdesc_get_property(hp, mp, "level", NULL);
 	const u64 *size = mdesc_get_property(hp, mp, "size", NULL);
 	const u64 *line_size = mdesc_get_property(hp, mp, "line-size", NULL);
+	const u64 *assoc = mdesc_get_property(hp, mp, "associativity", NULL);
 	const char *type;
 	int type_len;
 
@@ -828,15 +829,21 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struct mdesc_handle *hp, u64 mp)
 		if (of_find_in_proplist(type, "instn", type_len)) {
 			c->icache_size = *size;
 			c->icache_line_size = *line_size;
+			c->icache_assoc = assoc ? *assoc : 0;
+			c->icache_id = mp;
 		} else if (of_find_in_proplist(type, "data", type_len)) {
 			c->dcache_size = *size;
 			c->dcache_line_size = *line_size;
+			c->dcache_assoc = assoc ? *assoc : 0;
+			c->dcache_id = mp;
 		}
 		break;
 
 	case 2:
 		c->ecache_size = *size;
 		c->ecache_line_size = *line_size;
+		c->ecache_assoc = assoc ? *assoc : 0;
+		c->ecache_id = mp;
 		break;
 
 	default:
@@ -1251,6 +1258,60 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
 	smp_fill_in_sib_core_maps();
 }
 
+int init_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *i = get_cpu_cacheinfo(cpu);
+	i->num_levels = 2;
+	i->num_leaves = 3;
+	return 0;
+}
+
+int populate_cache_leaves(unsigned int cpu)
+{
+	struct cacheinfo *leaf = get_cpu_cacheinfo(cpu)->info_list;
+	cpuinfo_sparc *cs = &cpu_data(cpu);
+
+	leaf->id                    = cs->icache_id;
+	leaf->attributes            = CACHE_ID;
+	leaf->level                 = 1;
+	leaf->type                  = CACHE_TYPE_INST;
+	leaf->coherency_line_size   = cs->icache_line_size;
+	leaf->ways_of_associativity = cs->icache_assoc;
+	leaf->size                  = cs->icache_size;
+	leaf->priv                  = cs;
+	if (cs->icache_line_size > 0 && cs->icache_assoc > 0)
+		leaf->number_of_sets = cs->icache_size / cs->icache_line_size /
+		                       cs->icache_assoc;
+	++leaf;
+
+	leaf->id                    = cs->dcache_id;
+	leaf->attributes            = CACHE_ID;
+	leaf->level                 = 1;
+	leaf->type                  = CACHE_TYPE_DATA;
+	leaf->coherency_line_size   = cs->dcache_line_size;
+	leaf->ways_of_associativity = cs->dcache_assoc;
+	leaf->size                  = cs->dcache_size;
+	leaf->priv                  = cs;
+	if (cs->dcache_line_size > 0 && cs->dcache_assoc > 0)
+		leaf->number_of_sets = cs->dcache_size / cs->dcache_line_size /
+		                       cs->dcache_assoc;
+	++leaf;
+
+	leaf->id                    = cs->ecache_id;
+	leaf->attributes            = CACHE_ID;
+	leaf->level                 = 2;
+	leaf->type                  = CACHE_TYPE_UNIFIED;
+	leaf->coherency_line_size   = cs->ecache_line_size;
+	leaf->ways_of_associativity = cs->ecache_assoc;
+	leaf->size                  = cs->ecache_size;
+	leaf->priv                  = cs;
+	if (cs->ecache_line_size > 0 && cs->ecache_assoc > 0)
+		leaf->number_of_sets = cs->ecache_size / cs->ecache_line_size /
+		                       cs->ecache_assoc;
+
+	return 0;
+}
+
 /* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc is
  * opened. Hold this reference until /dev/mdesc is closed to ensure
  * mdesc data structure is not released underneath us. Store the
-- 
2.56.0

