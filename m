Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D0341667
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729843; cv=none; b=B+SSnAME+4VZ8IIPgfTXgH4WmDpV+G2eEckRB2JS9CDptzhC2D4ezm8zj3R3GcInLBl1EMvupnfM+fwJ+LHUUAIvTB5Y9ch3Q5hzwY3j4d3dOF0WCaU5mGpMCs4mANrveBPYmXimIurw4sBV7RiZS1RN9pBxekHJHNh2c3G9Z3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729843; c=relaxed/simple;
	bh=9n+C3fET0UdrKfrPUwqRR2f8H4KY9e0xGraCp8J0d+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fS/I2ViM6g5F++W3hQHEakOGYZiWoCTgJAPoXRBt16IJZwp0PxTneXEIa7xszh2JTpm3UkYOqK/N83NBCWG+QArxJZ6OcFoHHrOQXoJuQ5uWejmIC6x5odNaerM5ybiuxvO1Fibe/8RMm1briB/eAYbSF4v0KkBD8cRwhWrJS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iaW8xa4i; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iaW8xa4i"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61e8fdfd9b4so2129964a12.1
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729839; x=1757334639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URv9x64q4vLQVSw6o/AGB0bIgfNWsPBlnMBV30KLfzY=;
        b=iaW8xa4ixhM+LTYGmev2az60zgpZWvI91xXea08Io5F+m/O1gwS00FegsyOOF6sKb5
         /4+/q770mk5GIELcOT032omeW9cv5OWVvk6bH5ogG+DW4EPciuqKuvQXKgXn1OWIbC85
         k0xsN2NehDuYZxbkB2QBlEq4Y0lnCHVFXGgaO+RzdA8F1j1psr+XIs7O/pljsVu3IXOe
         q1MaS9Df+fQstecqkfhvBWyb8NABez54OdePJLh1xdbq4t8FEOPp8caNQi8tfInuGaed
         ygVrEkcEhInnYBUp5/z2S2Z1tuPGcbYENIlGC+1hRQcHvM9nP/LijLQzinoaKXyCjSAF
         8iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729839; x=1757334639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URv9x64q4vLQVSw6o/AGB0bIgfNWsPBlnMBV30KLfzY=;
        b=j2HVibcrjuNuDHsEsq2WPwnQQMydRaahrAf2F0ABLl3qI29lUMzHLHflh5Nugebjhz
         bpMylrmORuxDYEogviLR21Y1xyCN69Ecbkgki1O5RDQPYrJm+7ou+eWz2H1YdvKLZrLx
         Zbo5HkiTy6ynHtNr6Bxb5g3+UBd2lJgM/b2ZQnEEzKEj/PPdZ0SsgQ+EKHrSVcHtnb3l
         eaVsVpZKtEauGljMTesMZ5CfNXnjMdC3N+vhJY3RpfRFerRT0b8Aei8/LfG9Pzuf9KDo
         5yCRpnFcWMky7EDhTfRWW89e8e1zx35ZWV5YdSehJefVm0ukvGURs4Hfb+kVUrzsLN1G
         p7aA==
X-Forwarded-Encrypted: i=1; AJvYcCU1r6fIDXVGFgYfnkWMcjKrK16qx9fUfSbh0rUDGhsKHWFhpD7XAN3TB5zrpu6gwEuuUZQO+vD8EyDr@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeIi3sngdWH7W4SDXchH4Xf5J8jxgmdl56Ro7GbmMaas7//Hx
	Dk+jtQJmymvmtaGwKhdqpf4chQpKzyGWsiNcEJvUWuj8q4aTNVafqlHP/tNxrRcuplU=
X-Gm-Gg: ASbGncuKz5qdnIBI7SwSPkVrfk4ujxabRjCos6VxjRVMAwObBT/2ORy9rBUp4281637
	JukJ57lNLas26py5W6wUlA5GR+qn29vVoeeqGBYsHdrfGGKN+s2w7nw3ZAFSd8fh9SxQqgc8Ycf
	JzAMwuu08fCzGRxKtN5QtdTtrWL7F6vFfBrnMCV+s0ACcho9kAv1acrg1YhlHgy2IZLyE+AfItW
	OKowdGeqn1qk4AHi94QRaM7FFrYNOwy8y6wtsD2g0TvBtZDjzjlM8E1GR9pw1UD4S3HUDX3YjL3
	NBNgK4sDPKbZTm0Pa8xVtWmuZooqrns2++4KSQ0kk7l2wC7s51W9Rqltn+UkCWBbtDvF7SHd6LS
	6Jd//TIQ4e8kZcz59pGeeE5rlS7QSBgMjQvCdwwP/+YFmo2cHBAzA2EW/BcG/bw2wYsVW/EMLfZ
	t65x0dKxEIR9MPGv9dvzOwug==
X-Google-Smtp-Source: AGHT+IGvocu+GUM7r7JllEB1alYpzYWhNpDwmZUi+589Y2v0utgEYLLGAevBr2manMrYMhc61uAlCQ==
X-Received: by 2002:a05:6402:504b:b0:618:3521:6842 with SMTP id 4fb4d7f45d1cf-61d26d9c52dmr7127139a12.16.1756729838873;
        Mon, 01 Sep 2025 05:30:38 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:38 -0700 (PDT)
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
Subject: [PATCH v5 03/12] mm: constify zone related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:19 +0200
Message-ID: <20250901123028.3383461-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

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

