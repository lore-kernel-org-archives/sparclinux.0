Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753610;
	b=llToDreTGXgtTPydoAr+Es02x59wi62fsRkSozKroG4897AntSyePYMpC8yx0zkHDjjl
	 DVS7JIq1pQSFriPkIqUwuosqjVqNOrUGR5jd62p2xMhulHW421y6YxLnlDMWjimAioM64
	 27zhtfDRMio47EanEdrvjzjyRPmlyK8wRU1GG6Dx6LF4nH2N/Y8j0b3fij5y1ER8GUggV
	 yqDiof6z7jWG6bPFKXcFs+u1kTS5+6+w9sPe9aTfpElnzxU9nhTb0Fn+g2mIpPJepqJjn
	 7k4mfScIpyyTLSLWkw0WzvDw7sVsHfOgFanbYeYXK+PhB8xbsqZ/HZKvX0Wg3ReYR7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753610;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RJ6uaivQ8BwLLrJ0jFx1dkl7pROSrcgg9xW8jLyRpLQ=;
	b=alWn3ToM4ER0PIsMenbhS16BW2VrDUZkigNTNdrBe0wd+oPy89eNxW+nRzmotwTbQISD
	 kHCi/drjsJbowLwKvhvqwpANTLNTaoYeLTVIpo7m5FkwrBWboz3LMP5EVdSw1yzJgE0o4
	 2FcHY8WkbshKqJeK7BFdJp7Ri1JWIO8/mDjkV/EsRZqZliJWl/JwVAZqDKNvzby6tEihq
	 nOIdnLBQn5kVeoLjzLvbo3aYTxqoNhUh5+qWxkz6OHi5JQ+LZqrJtTixuRHLFMGwgrwyF
	 axRkIPsIZpCQX2TFnMumioODtd0hUPUvqaMDUvDlWXgr3BWesopyg/vRg+GrFI1LCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GZYfrw51;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDBC606A31F;
	Sun, 15 Nov 2026 14:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDBC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GZYfrw51
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B9321476;
	Sun, 15 Nov 2026 06:40:06 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C89E13F85F;
	Sun, 15 Nov 2026 06:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794753609; bh=pLgKf4mawFqqvvE6RCmjujIRPi4np4jf4M8uyT2QPys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZYfrw51urDn166LlLx+/pYfMV08jB7U+8n3cqNCRyna+srdZI7M8UD1BkjM4jBP1
	 4AqDTGF7839HkxoPfKxgkcgxEzn0joIGu2JpiYhSoDR9EGjFQm8D8z5inkacRLK/pn
	 So1uiume8SR5ut3NLofJIy6gCEcViN5twc1FFnEs=
From: Dev Jain <dev.jain@arm.com>
To: david@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	davem@davemloft.net,
	andreas@gaisler.com
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	baolin.wang@linux.alibaba.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	anshuman.khandual@arm.com,
	geert@linux-m68k.org,
	sparclinux@vger.kernel.org,
	ryan.roberts@arm.com
Subject: [PATCH v4 6/9] mm/internal: add set_softleaf_ptes
Date: Sun, 15 Nov 2026 14:39:01 +0000
Message-ID: <20261115143905.3045084-7-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115143905.3045084-1-dev.jain@arm.com>
References: <20261115143905.3045084-1-dev.jain@arm.com>
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

Currently we have a helper called set_ptes() which is used to set
consecutive present ptes in the pgtables. To do the same operation but
to set "consecutive" nonpresent (softleaf) ptes, add set_softleaf_ptes().

The softleaves which have a notion of consecutivity is swap softleaf,
and those grouped by softeaf_has_pfn(). The latter is trivial; future
code can convert present ptes pointing to the same large folio to
swap softleaves with consecutive offsets using this helper.

The other case is softleaf markers. They do not have a notion of a swap
offset or PFN, so future code can use set_softleaf_ptes() to store
multiple (same) markers on the ptes.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/internal.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index eaada62a86590..c7f330db6a2e5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -512,6 +512,39 @@ static inline pte_t pte_next_softleaf_offset(pte_t pte)
 	return pte_move_softleaf_offset(pte, 1);
 }
 
+/**
+ * set_softleaf_ptes - Set consecutive softleaf PTEs.
+ * @mm: Address space the PTEs belong to.
+ * @addr: Address of the first PTE.
+ * @ptep: Page table pointer for the first PTE.
+ * @pte: PTE to set for the first entry.
+ * @nr: Number of PTEs to set.
+ *
+ * Install @nr softleaf PTEs, advancing @pte when its softleaf entry
+ * represents consecutive offsets. Swap entries advance through swap offsets,
+ * PFN softleaf entries advance through PFNs (encoded by swap offset), and
+ * marker entries are repeated unchanged.
+ */
+static inline void set_softleaf_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned long nr)
+{
+	softleaf_t entry;
+	bool advance;
+
+	entry = softleaf_from_pte(pte);
+	advance = softleaf_is_swap(entry) || softleaf_has_pfn(entry);
+
+	for (;;) {
+		set_pte_at(mm, addr, ptep, pte);
+		if (--nr == 0)
+			break;
+		if (advance)
+			pte = pte_next_softleaf_offset(pte);
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
 /**
  * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
  * @start_ptep: Page table pointer for the first entry.
-- 
2.43.0

