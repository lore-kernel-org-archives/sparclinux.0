Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com [220.197.32.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7E385D64;
	Thu,  4 Jun 2026 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545448; cv=none; b=mM1noxKj70ox5B9gFkGu2pa/EUrsoG8v66/zskCXUDzo/O/na7Qi5ZDyRdYfwWPmRrMbvNmdSE+W6g0N3r9Ppil6RO2X/9PsqPoe8AQ+oNqIkAaxjr+z4S6RLMY1+koiaQvtb+3GPg9MiYZ8YpimvK7qyClPCVHWTNwRcuUUSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545448; c=relaxed/simple;
	bh=1u3F/aoC6HL/yemRtFbMBLltKiZI89utQxKpmFnStf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tXtZ6lkz6pP7e/Ao034b6GZnLFqGZ74fjl9q9+rPGtonPFpdsdmj0lUDb/PkN7Pne5KKhV902y9rCtsPa/OEJiw+hnSOSWwDFhC+D1NNU+2+SMgOJ8GjgjUR51IxxxM0gu80e0W1mcr6JQW05z503hCR+oP85Dm7+Rl/jwYIr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1afc83ec1;
	Thu, 4 Jun 2026 11:41:52 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] mm/memblock: Introduce memblock_alloc_node_or_panic() helper
Date: Thu,  4 Jun 2026 11:41:39 +0800
Message-Id: <20260604034139.2827148-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e90b9218b0229kunm3abe23872c1e40
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH08eVkwdTU8YQ01MQkpNHlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lCQ0NMVUpLS1VLWQY+

During early boot, several subsystems allocate memory from specific
NUMA nodes using memblock_alloc_node(). When allocation fails, the
typical requirement is to panic immediately.

Introduce memblock_alloc_node_or_panic() to automatically panic on
allocation failure. This reduces repetitive error checking, improves code
consistency across subsystems, and enhances code readability.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 arch/sh/mm/numa.c            | 10 ++++------
 arch/sparc/kernel/setup_64.c | 16 ++++++----------
 arch/x86/coco/sev/core.c     |  5 ++---
 include/linux/memblock.h     |  6 ++++++
 mm/memblock.c                | 22 ++++++++++++++++++++++
 mm/mm_init.c                 | 11 ++++-------
 mm/sparse.c                  | 13 +++++--------
 7 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index 9bc212b5e762..32b01697b27f 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -38,12 +38,10 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 	__add_active_range(nid, start_pfn, end_pfn);
 
 	/* Node-local pgdat */
-	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
-					     SMP_CACHE_BYTES, nid);
-	if (!NODE_DATA(nid))
-		panic("%s: Failed to allocate %zu bytes align=0x%x nid=%d\n",
-		      __func__, sizeof(struct pglist_data), SMP_CACHE_BYTES,
-		      nid);
+	NODE_DATA(nid) = memblock_alloc_node_or_panic(
+				sizeof(struct pglist_data),
+				SMP_CACHE_BYTES,
+				nid);
 
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b4..57e3a45f4750 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -606,16 +606,12 @@ static void __init alloc_irqstack_bootmem(void)
 	for_each_possible_cpu(i) {
 		node = cpu_to_node(i);
 
-		softirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
-						       THREAD_SIZE, node);
-		if (!softirq_stack[i])
-			panic("%s: Failed to allocate %lu bytes align=%lx nid=%d\n",
-			      __func__, THREAD_SIZE, THREAD_SIZE, node);
-		hardirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
-						       THREAD_SIZE, node);
-		if (!hardirq_stack[i])
-			panic("%s: Failed to allocate %lu bytes align=%lx nid=%d\n",
-			      __func__, THREAD_SIZE, THREAD_SIZE, node);
+		softirq_stack[i] = memblock_alloc_node_or_panic(THREAD_SIZE,
+								THREAD_SIZE,
+								node);
+		hardirq_stack[i] = memblock_alloc_node_or_panic(THREAD_SIZE,
+								THREAD_SIZE,
+								node);
 	}
 }
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 7ed3da998489..0191835dd5de 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1191,9 +1191,8 @@ static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
 
-	data = memblock_alloc_node(sizeof(*data), PAGE_SIZE, cpu_to_node(cpu));
-	if (!data)
-		panic("Can't allocate SEV-ES runtime data");
+	data = memblock_alloc_node_or_panic(sizeof(*data), PAGE_SIZE,
+					    cpu_to_node(cpu));
 
 	per_cpu(runtime_data, cpu) = data;
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b0f750d22a7b..9b22d7fc0dc7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -433,6 +433,12 @@ void *__memblock_alloc_or_panic(phys_addr_t size, phys_addr_t align,
 #define memblock_alloc_or_panic(size, align)    \
 	 __memblock_alloc_or_panic(size, align, __func__)
 
+void *__memblock_alloc_node_or_panic(phys_addr_t size, phys_addr_t align,
+				     int nid, const char *func);
+
+#define memblock_alloc_node_or_panic(size, align, nid)    \
+	 __memblock_alloc_node_or_panic(size, align, nid, __func__)
+
 static inline void *memblock_alloc_raw(phys_addr_t size,
 					       phys_addr_t align)
 {
diff --git a/mm/memblock.c b/mm/memblock.c
index ccd43f3abb82..2e97cd6d21a1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1845,6 +1845,28 @@ void *__init __memblock_alloc_or_panic(phys_addr_t size, phys_addr_t align,
 	return addr;
 }
 
+/**
+ * __memblock_alloc_node_or_panic - Try to allocate memory on a node and panic on failure
+ * @size: size of memory block to be allocated in bytes
+ * @align: alignment of the region and block's size
+ * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
+ * @func: caller func name
+ *
+ * This function attempts to allocate memory on a specific node using memblock_alloc_node,
+ * and in case of failure, it calls panic with the formatted message.
+ * This function should not be used directly, please use the macro memblock_alloc_node_or_panic.
+ */
+void *__init __memblock_alloc_node_or_panic(phys_addr_t size, phys_addr_t align,
+					     int nid, const char *func)
+{
+	void *addr = memblock_alloc_node(size, align, nid);
+
+	if (unlikely(!addr))
+		panic("%s: Failed to allocate %pap bytes on node %d\n",
+		      func, &size, nid);
+	return addr;
+}
+
 /*
  * Remaining API functions
  */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..7c69056c1a8c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1477,14 +1477,11 @@ static void __ref setup_usemap(struct zone *zone)
 	unsigned long usemapsize = usemap_size(zone->zone_start_pfn,
 					       zone->spanned_pages);
 	zone->pageblock_flags = NULL;
-	if (usemapsize) {
+	if (usemapsize)
 		zone->pageblock_flags =
-			memblock_alloc_node(usemapsize, SMP_CACHE_BYTES,
-					    zone_to_nid(zone));
-		if (!zone->pageblock_flags)
-			panic("Failed to allocate %ld bytes for zone %s pageblock flags on node %d\n",
-			      usemapsize, zone->name, zone_to_nid(zone));
-	}
+			memblock_alloc_node_or_panic(usemapsize,
+						     SMP_CACHE_BYTES,
+						     zone_to_nid(zone));
 }
 #else
 static inline void setup_usemap(struct zone *zone) {}
diff --git a/mm/sparse.c b/mm/sparse.c
index effdac6b0ab1..c7c80783b6be 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -66,15 +66,12 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
 	unsigned long array_size = SECTIONS_PER_ROOT *
 				   sizeof(struct mem_section);
 
-	if (slab_is_available()) {
+	if (slab_is_available())
 		section = kzalloc_node(array_size, GFP_KERNEL, nid);
-	} else {
-		section = memblock_alloc_node(array_size, SMP_CACHE_BYTES,
-					      nid);
-		if (!section)
-			panic("%s: Failed to allocate %lu bytes nid=%d\n",
-			      __func__, array_size, nid);
-	}
+	else
+		section = memblock_alloc_node_or_panic(array_size,
+						       SMP_CACHE_BYTES,
+						       nid);
 
 	return section;
 }
-- 
2.20.1

