Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF9C30C359
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718373; cv=none; b=bivO3fxHfP9I0gKf03tcAZ+nfxYEDuFFR77WaYs5IP2RGWsUZJ+HJtDUBx8kfeiSYSAme5REWKQ0pftc9ldWLZSrOS8R1nvQLeb3aP0gHhOzDslV2AFqGSe6YSE0bOd2TJ91Rbz6FTIIrevP9WvY3mSJEiDD+iE3MLHs9qO9vKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718373; c=relaxed/simple;
	bh=CA31iYHaJYjhA+6MC6gAAULqKffDNHYdwy1DfsmSunE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns1FgVmNb5yO/0wDPNO6xpEYfxgxhUTfQoBIc5l5oehPSZm5KdAi2rex0dGxZUqNkc6E+UnzFUej4hGYwvqMueWp6hDQJwwXYorefNsaqi/JrsfnMvg2hYKtpTrn+CLfgOchxB/DhmKlbONg/Lhdm6jVTETjgs/FntcXHKng8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fwaETpNy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fwaETpNy"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b040df389easo252219266b.3
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718370; x=1757323170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqkRolEiPUj7RJL2rUljUH40PaguAeYrnxbluGnyi6U=;
        b=fwaETpNy9ZuzyfL//W+5jOUIUPpukTk8aGq8d7gTKF/oAJ2MDe3RpOmIN7/tzRgxBp
         0g77z4CsjbOwrrAgo8vG5AfPpl65o4YuczpaNrpZjPd/oMxz7+AQqr7bKGfvx5fEGS/G
         sQvG5ZDT9JNTiYOoQQlYGeO59t781P5CZ0mGzWjanwjy0ttFcLon6CWrD6AjR3F+J0zI
         jWT02axUoZt3Wa+eVo7QcNPpGXyNg8rVyAuSF2LuJ6tlF8HnF5kMbJdY0p5V6pZUnzkb
         LdAuq2hErU1MBpgT6ZN90paTTGRsZ6dUZCXQSuSikyvC8WEbkCi3z8JXy3s+6obeH/53
         U9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718370; x=1757323170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqkRolEiPUj7RJL2rUljUH40PaguAeYrnxbluGnyi6U=;
        b=eJzNnmnTSfkoQHY+Q08pOmRqFNANlKlnYXRGyL4RmWA90nfABCGcuWnoxzAFnYtEY0
         KoGVsZP2bHrQ5dDpXAMqyrEAxq0lOj6ZANU+HiH8kF/PJKSw5zJWFcyb61dvKyKog3HZ
         GOZtBKetLs+pVxalj8t6PGRWr8SrAh+DiYE4vJ7HDbUpbMvr+zvHhK8P/ySLCGuQp8+0
         N4HNHBrzUj0811idoi5XuW8fbM+daW6bevEM1+QEzd7UeWvBwDOZ8/bRe5+1TU+oU9Ro
         bn2M9exvcA/q6wotSH7n/EozfLXxb6AThWRJqrpZktpJgivmKaVY7l/a/nK7qMX1IDwD
         uvPw==
X-Forwarded-Encrypted: i=1; AJvYcCUmqWwz9bLfttMdhGwop64R/debeH/r6HMogTmP1bepw+d/b0zrpivLm8XRNpAvpeMJgNM4ByMWfMYs@vger.kernel.org
X-Gm-Message-State: AOJu0YxA77VOE0MPagJSy0KPOj3YNjMQnCu6esDP886Q//K4MxxaXhKe
	SpCtE1f6YRLvpGgDmdEAwT1P7t8XjKe/syaxyqTtNrCmBVybNd5KBwbJVqIQUKWYArc=
X-Gm-Gg: ASbGncuxBAo/N4eA2k2GAMCC38SVw3L9MRXhi4Ztn2CW9LvJ9nXJrU2mZN5j/IOpbPC
	+5xfgUgLfFarH9lrd7dJzoGtkWbQ+8yPabYo4w226ymL3ztJiI02oC/AwhKUx5/SP0+EqnCIQlN
	ADnJCb7JDimTi4oU7Udke2JXHKZvJG5Ybxl7FuU3ocmE74YxFs8XJI8PvOzY/oFl4UKAyUHH5VI
	457sj5uSR9No15JHEe40Qz1Mf8uspSWXkHKMpIdVRMn4NT5NYe2HUoS1jc0OxbhEX2NhIYehfHX
	KXi8iTN4xRzt2mOxNgEIQ8hMaGMASnyP+h7Gke32nMlMhXk9a3UahtC2U1cRkxnmseGhHZwDxzp
	VOpfdzo2BpiexlbzF17hySLBUgU15jUWTWFtrT6UaI9MiQQAXiorKNe6cZF256/sdSJUSNTbikw
	1v4mkaWSmCQlwF6vuIDd2ChRWLNeD+/Xz9
X-Google-Smtp-Source: AGHT+IEsmw8mc9FR+7YcDO3uHr7qQk2IFaFGO9lGAZi9GzeSVQNoy7S8eVMSnXBGPw6W32MtA4kZ+g==
X-Received: by 2002:a17:907:2684:b0:aff:13f5:1f0 with SMTP id a640c23a62f3a-b01d8a26e65mr628763966b.7.1756718369507;
        Mon, 01 Sep 2025 02:19:29 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:29 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 03/12] mm/mmzone: add const to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:06 +0200
Message-ID: <20250901091916.3002082-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to zone, zoneref, and mem_section pointer
parameters in mmzone.h functions that do not modify the referenced memory,
improving type safety and enabling compiler optimizations.

Functions improved:
- zone_managed_pages()
- zone_is_initialized()
- zone_is_empty()
- zone_intersects()
- zone_is_zone_device()
- managed_zone()
- populated_zone()
- zone_to_nid()
- is_highmem()
- zonelist_zone_idx()
- zonelist_node_idx()
- present_section()
- valid_section()
- early_section()
- online_section()
- online_device_section()
- preinited_vmemmap_section()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mmzone.h | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f3272ef5131b..9a25fb1ade82 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1104,7 +1104,7 @@ static inline unsigned long promo_wmark_pages(const struct zone *z)
 	return wmark_pages(z, WMARK_PROMO);
 }
 
-static inline unsigned long zone_managed_pages(struct zone *zone)
+static inline unsigned long zone_managed_pages(const struct zone *const zone)
 {
 	return (unsigned long)atomic_long_read(&zone->managed_pages);
 }
@@ -1128,12 +1128,12 @@ static inline bool zone_spans_pfn(const struct zone *zone, unsigned long pfn)
 	return zone->zone_start_pfn <= pfn && pfn < zone_end_pfn(zone);
 }
 
-static inline bool zone_is_initialized(struct zone *zone)
+static inline bool zone_is_initialized(const struct zone *const zone)
 {
 	return zone->initialized;
 }
 
-static inline bool zone_is_empty(struct zone *zone)
+static inline bool zone_is_empty(const struct zone *const zone)
 {
 	return zone->spanned_pages == 0;
 }
@@ -1273,7 +1273,7 @@ static inline bool folio_is_zone_movable(const struct folio *folio)
  * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
  * intersection with the given zone
  */
-static inline bool zone_intersects(struct zone *zone,
+static inline bool zone_intersects(const struct zone *const zone,
 		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (zone_is_empty(zone))
@@ -1581,12 +1581,12 @@ static inline int local_memory_node(int node_id) { return node_id; };
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *const zone)
 {
 	return zone_idx(zone) == ZONE_DEVICE;
 }
 #else
-static inline bool zone_is_zone_device(struct zone *zone)
+static inline bool zone_is_zone_device(const struct zone *const zone)
 {
 	return false;
 }
@@ -1598,19 +1598,19 @@ static inline bool zone_is_zone_device(struct zone *zone)
  * populated_zone(). If the whole zone is reserved then we can easily
  * end up with populated_zone() && !managed_zone().
  */
-static inline bool managed_zone(struct zone *zone)
+static inline bool managed_zone(const struct zone *const zone)
 {
 	return zone_managed_pages(zone);
 }
 
 /* Returns true if a zone has memory */
-static inline bool populated_zone(struct zone *zone)
+static inline bool populated_zone(const struct zone *const zone)
 {
 	return zone->present_pages;
 }
 
 #ifdef CONFIG_NUMA
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *const zone)
 {
 	return zone->node;
 }
@@ -1620,7 +1620,7 @@ static inline void zone_set_nid(struct zone *zone, int nid)
 	zone->node = nid;
 }
 #else
-static inline int zone_to_nid(struct zone *zone)
+static inline int zone_to_nid(const struct zone *zone)
 {
 	return 0;
 }
@@ -1647,7 +1647,7 @@ static inline int is_highmem_idx(enum zone_type idx)
  * @zone: pointer to struct zone variable
  * Return: 1 for a highmem zone, 0 otherwise
  */
-static inline int is_highmem(struct zone *zone)
+static inline int is_highmem(const struct zone *const zone)
 {
 	return is_highmem_idx(zone_idx(zone));
 }
@@ -1713,12 +1713,12 @@ static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 	return zoneref->zone;
 }
 
-static inline int zonelist_zone_idx(struct zoneref *zoneref)
+static inline int zonelist_zone_idx(const struct zoneref *const zoneref)
 {
 	return zoneref->zone_idx;
 }
 
-static inline int zonelist_node_idx(struct zoneref *zoneref)
+static inline int zonelist_node_idx(const struct zoneref *const zoneref)
 {
 	return zone_to_nid(zoneref->zone);
 }
@@ -2021,7 +2021,7 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
 	return (struct page *)map;
 }
 
-static inline int present_section(struct mem_section *section)
+static inline int present_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
 }
@@ -2031,12 +2031,12 @@ static inline int present_section_nr(unsigned long nr)
 	return present_section(__nr_to_section(nr));
 }
 
-static inline int valid_section(struct mem_section *section)
+static inline int valid_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
 }
 
-static inline int early_section(struct mem_section *section)
+static inline int early_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_EARLY));
 }
@@ -2046,27 +2046,27 @@ static inline int valid_section_nr(unsigned long nr)
 	return valid_section(__nr_to_section(nr));
 }
 
-static inline int online_section(struct mem_section *section)
+static inline int online_section(const struct mem_section *const section)
 {
 	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *const section)
 {
 	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
 
 	return section && ((section->section_mem_map & flags) == flags);
 }
 #else
-static inline int online_device_section(struct mem_section *section)
+static inline int online_device_section(const struct mem_section *const section)
 {
 	return 0;
 }
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *const section)
 {
 	return (section &&
 		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
@@ -2076,7 +2076,7 @@ void sparse_vmemmap_init_nid_early(int nid);
 void sparse_vmemmap_init_nid_late(int nid);
 
 #else
-static inline int preinited_vmemmap_section(struct mem_section *section)
+static inline int preinited_vmemmap_section(const struct mem_section *const section)
 {
 	return 0;
 }
-- 
2.47.2

