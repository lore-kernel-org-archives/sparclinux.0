Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177363;
	b=SWw5LUBTnjbXv0pfhSUCcNuYzyDnNnfpp9H4IqP26yGJUN5/yO8ToM5ZSS4k7G8pvF1n
	 e9J73WUIWI3pNEQMohg4+vwS267KPSyshgdtqHvAHhdQ8TmKYGHRPiFk8VCUCazMOKRTl
	 0W51/dSQ/REdg1fjwatiVLYBS1ree6XJvtcDNlPeBEpfLV5GOmxM0W8MQTV2KWdWQU85W
	 Sf2LnwSyOiAYLTiw9z7RDoeNEV3a/+G0fo2OLRzaIMbfaYgZ8Gy2d27Le3D4fiHJAxZXw
	 IoWil1mxbCgdMrRdzGIyd4jcP3Fgu9DA8wX5Ink9mAZUSoaz6h2dLg9yuRqgHKMpj+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1kNf7/T6Z3Z9x33XOj8xN/pKgMapC3Cz/qc8M6FMmZs=;
	b=ZH/7AWzHSxw3ZcMk2QlWUyDdm2y6dt+zWUuJw1e2I8AySGn5bwQAciBh9bsoFLSWHLxO
	 Qmv4Nl9Dnc+GJEZ2/rxwCtus8516awLCNkT4eWDaETJ8IfIi7boQZ77Tx8eAkUgr8d77c
	 wr+Qw0mQz54yq/MB765iZfj1S/UlEqJQwqClbll1/kpCT2bDwOWpwJYG16fqOgWQnVMH9
	 OjvGJTrS78xQKwJwheUTu2th8ovqiRl93Z3+8pTgpK2gF7Uxm992Vn47T/l2IYgkJERa/
	 NBtw7eGqvZEp/mmyKa1Au4OxFa9qXkf8i1jmv7tI5wrl9/2eYAZ19qRStRC6uci6XJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShDTzBtj;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF9606D81F
	for <sparclinux@vger.kernel.org>; Sun,  8 Nov 2026 22:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7BF9606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShDTzBtj
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4ceaee6770so38813966b.0
        for <sparclinux@vger.kernel.org>; Sun, 08 Nov 2026 14:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177361; x=1794782161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kNf7/T6Z3Z9x33XOj8xN/pKgMapC3Cz/qc8M6FMmZs=;
        b=ShDTzBtjwSJXqCMUEGb41FMhfMCTTwW4HowLQCzZKTOq5TPR8B+oJmlWU0VXWp52un
         pH2EFzrQjftXsAXbJiSx0VG8GWoMjew7u9AEjPk3kVUN2nhQZgNacTUoOpLtYMku4sbu
         8G600W8DRgFXm9rfHZ5yoWELYtmGh2R3zZCQ7WXgX/UuAMVXplzjC9nUsk1wMbIHlX+l
         s43+GotMUmZwMqn6b+83G1vAXAgfwgXtkJ1UHeIF/nUXIcmsUBaeRy8on4nHjT/OnSQ6
         ZnjPwBCB/cjzS2NWFqBJIo3htOBmYBxvOLTOFImIQFDbcvouSsStUfcxGJo8sg2QxALz
         zifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177361; x=1794782161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kNf7/T6Z3Z9x33XOj8xN/pKgMapC3Cz/qc8M6FMmZs=;
        b=Zding6BZM4GGOlDPugaWl79ZwewzsRPqyj9JqBfiv0X5BplY9MN5U2NVo4FcSVQnhJ
         hhfWg3tL2AmHpDC+lmHtakrnC+2OAi3dRoytvnxXIRNDf5pGaIO0PI9zrWQFyObY33yT
         xDlcrd19N7qnLzyC76t187dOsIieypiujHvZx4u7LO8U4yi/qQKNyOOclC8pDcQPvVuS
         0WyDfcCreBTbaWHuIsF7HYd3Wly9Wte2Lyol19e/s+ErO0kVneQ5Z9keXpCPaeR7Ufs/
         YtGa2z0O9DyS6iw+peyGBvSqRJbJMYJu4/+w/lw55i2q4dyF9jKrFLJ/xZrAc6Uj825j
         LwPQ==
X-Gm-Message-State: APuU4Z9pZkuZqQ0Jy+bvTXdNBQztF3tEftBnZGCyP43KNAQAf8+QBBAr
	LEa1xjP3/K12MLFn/eMag6g0Rdit+iahcu1id9FxMEqIjt6EWeDHgMej
X-Gm-Gg: AYBFou0zdorDhrthlES8Q2I4LRNvlzD+C1DeOGsg0Tne/En7m+IJnkSwfD/zYViWM9k
	NGwvOf5W8jns+awhELdpxIJ4QVtcOq8/E4kOxV7/tFFFblr3COCGlzyZpG/GUye9OhPKxNKjbuo
	ShtdueXEr3C9MELi7dWkppkycardkUeR5QsAJgUZW3ni7sX2rPbNFqPpiXo2pFa0u4n4KtKZA/D
	T/EWmJJqvb8hBZ9UJDnilqtGEq0N0BcrOFCT/CIs5Oz/sY12oP3ekBvlC703wGudl7Oz9tK8Yu+
	NFkBWqWhH1MOMwQF3/IbD/y02BG3R16OMNgFQKwPBhQTSP7RonA98uKWZ1vMWLN/VoSXcveBBM5
	8DHBQZ3hE2a/Fk9yGelluJhfHhz2mzMoDGGuKtara2EEvsIPaZGYEJt0GCRgzUJhxC8aY1Rf/kd
	EnRdfjna9LvdGrtx7LcFjF16tSjV1EL+GSQDqpjUyXgyIfner+br6uRj3jQ09wxO7qBdg6S+OPR
	lhm2eYn7TW7b9gGg33k3HUxz3VjJWKuqFmSCJOV4sEV+dVp7/GGlbnYtqnEJ9cjWqNQHzCJqGXA
	WRZifc7kNf4HaO/khRYr/eI9ztGnQ8DuzyxnLST/2odSht4q6h2626CdE/PN0c2X8AERH3k=
X-Received: by 2002:a17:907:9347:b0:c36:a4b4:b1ed with SMTP id a640c23a62f3a-c4d6daf7d4emr185489266b.11.1794177361100;
        Sun, 08 Nov 2026 14:36:01 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebc7b0sm859272a12.14.2026.11.08.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:36:00 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 4/9] sparc32: flush the cache when a kmap_local mapping is installed
Date: Sun,  8 Nov 2026 23:34:14 +0100
Message-ID: <20261108223516.1125534-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108223516.1125534-1-linmag7@gmail.com>
References: <20261108223516.1125534-1-linmag7@gmail.com>
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

sparc32 defines arch_kmap_local_pre_map() as flush_cache_all(), but
generic highmem has never called that hook. The post-conversion flush
correction moved cache maintenance into this uncalled hook, so a new kmap
can be installed while another mapping of the same page still holds dirty
lines at a different colour.

A writer dirties a MAP_SHARED page through its user mapping on one cpu
while a reader pread()s the same offset on another: on an SS-20 with two
RT626 modules all 100 iterations came back stale, 96288 words wrong. With
the flush restored, 0 of 100.

Flush from arch_kmap_local_post_map(), which generic code does call, on
both the map and the scheduler restore paths. Running after the pte is
installed is safe: the address is not handed to the caller until the hook
returns. Route it and the tlb flush through sparc32_kmap_local_post_map()
and sparc32_kmap_local_tlb_flush() so later patches have somewhere for a
cpu-specific policy.

MBus supplies only optional VA[19:12] "super-set" bits to a virtually
indexed cache, so differing colours remain a synonym problem the bus does
not resolve.

Reference: MBus Interface Specification, SPARC International, 1997, "Basic
Assumptions for Level 2", signal VA[19:12] (MAD[53:46]).

Retain global TLB invalidation. Although the slots are CPU-local, remote
translating cache backends can populate entries for them. Local TLB
maintenance requires those remote translating users to be removed first
and belongs in the later HyperSPARC optimization.

Fixes: f99e02372af2 ("sparc/mm/highmem: flush cache and TLB")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/include/asm/highmem.h | 14 ++++++++++----
 arch/sparc/mm/srmmu.c            | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
index b1b915ac604d..14b03f348823 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -26,6 +26,10 @@
 #include <asm/vaddrs.h>
 #include <asm/pgtsrmmu.h>
 
+void sparc32_kmap_local_cache_flush(unsigned long vaddr);
+void sparc32_kmap_local_tlb_flush(unsigned long vaddr);
+void sparc32_kmap_local_post_map(unsigned long vaddr, pte_t pteval);
+
 #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
 extern pte_t *pkmap_page_table;
 
@@ -48,10 +52,12 @@ extern pte_t *pkmap_page_table;
 #define flush_cache_kmaps()	flush_cache_all()
 
 /* FIXME: Use __flush_*_one(vaddr) instead of flush_*_all() -- Anton */
-#define arch_kmap_local_pre_map(vaddr, pteval)	flush_cache_all()
-#define arch_kmap_local_pre_unmap(vaddr)	flush_cache_all()
-#define arch_kmap_local_post_map(vaddr, pteval)	flush_tlb_all()
-#define arch_kmap_local_post_unmap(vaddr)	flush_tlb_all()
+#define arch_kmap_local_pre_unmap(vaddr) \
+	sparc32_kmap_local_cache_flush(vaddr)
+#define arch_kmap_local_post_map(vaddr, pteval) \
+	sparc32_kmap_local_post_map(vaddr, pteval)
+#define arch_kmap_local_post_unmap(vaddr) \
+	sparc32_kmap_local_tlb_flush(vaddr)
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 49d41b33aabf..aa53ec10cd8a 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -88,6 +88,27 @@ static int is_hypersparc;
 
 static int srmmu_cache_pagetables;
 
+void sparc32_kmap_local_cache_flush(unsigned long vaddr)
+{
+	flush_cache_all();
+}
+
+/*
+ * Nothing has touched the new mapping yet, so flushing other aliases of this
+ * page here is as good as doing it before the pte was set.
+ */
+void sparc32_kmap_local_post_map(unsigned long vaddr, pte_t pteval)
+{
+	sparc32_kmap_local_cache_flush(vaddr);
+	sparc32_kmap_local_tlb_flush(vaddr);
+}
+
+void sparc32_kmap_local_tlb_flush(unsigned long vaddr)
+{
+	/* Remote translating cache operations can populate these entries. */
+	flush_tlb_all();
+}
+
 /* these will be initialized in srmmu_nocache_calcsize() */
 static unsigned long srmmu_nocache_size;
 static unsigned long srmmu_nocache_end;
-- 
2.43.0

