Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A284825AE;
	Thu, 24 Sep 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255551; cv=none; b=TZ11zkgbikWNhnMwBdQjMkBJv0J3uc9H+8ixbuDYw0DSwYkHcpQcD0Gz2zu3Uq551FI8FFiostl0y8tTZwaN0Jzil3m48Paxza2eRo6jQ0uYsxutcFCna6wRx0QNCWD5qXE2rdVxpHSvNvZtRyEZ/RIwsQJuTRyCCjScE3fInvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255551; c=relaxed/simple;
	bh=zg4Gpqj8nP6uUFsMj+aijEa4Qysw1f63qlOvk3k1K+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTAHa48u/1TMcXKeNgmWoqmZa7aRLp1b0ggiFnJQlBwCrmvH7fmnYQvaQ2YY20Tb7VsKV9dHt4NX3T1VJQQ8EOXdVWjluestfb+hURCotjwFqzGPAwxFa70y0OA+HnDMUxPq2EDgzFaFw9L2KN9KesehvXcvgAn34XGHmvkzNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e9ypsXuA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e9ypsXuA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC7691C14;
	Thu, 24 Sep 2026 06:12:18 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-01.blr.arm.com (cesw-amp-gbt-1s-m12830-01.blr.arm.com [10.164.195.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D3483FAA1;
	Thu, 24 Sep 2026 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790255542; bh=zg4Gpqj8nP6uUFsMj+aijEa4Qysw1f63qlOvk3k1K+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9ypsXuAUEFUhUGiy2kuIWnONzTqWzmAlFPKs4AetqbG7BtTn9f3qUlgSGgefbBFk
	 TolsSjzBbvi0sBApOPtUgZ/la9iLY1I3EWzAWzImW+e6a+yk4iaRJoyXCpF2qrQRgV
	 DNGkB4orI3Y2KQ0YV5/f+7q+t2n9XurcSsoRDn14=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
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
	jgg@ziepe.ca,
	thuth@redhat.com,
	sparclinux@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com
Subject: [PATCH v3 7/9] mm/memory: use set_softleaf_ptes for uffd-wp markers
Date: Thu, 24 Sep 2026 13:09:35 +0000
Message-ID: <20260924131106.1730494-8-dev.jain@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924131106.1730494-1-dev.jain@arm.com>
References: <20260924131106.1730494-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use set_softleaf_ptes() to store multiple uffd-wp marker entries instead
of open coding the batched setting.

Reviewed-by: Barry Song <baohua@kernel.org>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/memory.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 60fd0a08b35f5..bed5cd90356f4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1700,14 +1700,8 @@ bool cond_install_uffd_wp_ptes(struct vm_area_struct *vma,
 	if (likely(!arm_uffd_pte))
 		return false;
 
-	for (;;) {
-		set_pte_at(vma->vm_mm, addr, ptep,
-			   make_pte_marker(PTE_MARKER_UFFD_WP));
-		if (--nr_ptes == 0)
-			break;
-		ptep++;
-		addr += PAGE_SIZE;
-	}
+	set_softleaf_ptes(vma->vm_mm, addr, ptep,
+			  make_pte_marker(PTE_MARKER_UFFD_WP), nr_ptes);
 
 	return true;
 }
-- 
2.43.0

