Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A77214227;
	Mon,  3 Mar 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011366; cv=none; b=C/qoc671e9j1DjrvY3rFBxodLDI6jyTSFYnsVo2EmaIidp8zzCO+yJPluz3FtzixpkV54HepUca3BPm3vlYSximuv6/UVAQtWs58FRMVUORoVkXiaft2n05skwU68EMClFyBNomBQkxKg4EfxdWHZNhiG3py1vWSI/9maUCkmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011366; c=relaxed/simple;
	bh=rya0kgyfnlnpLPCSRTi6Y/jlT5vZGN17FLZ5g9rS9Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyQeh+P6dC60HYoQskF7oCZeNzqNUo3u6/aG6Y8g27Y6j7CA9cYxkJzXtYJGvG2DJUSiDI9Z94gUn5LfW+Ca6SEQdqDb235aOgofxJ+XscFZ1tpXiGgkTFHG9k+UFVX+cGISfhKJE+oSs2JGdatbrU7f3TSacQghhc9seRm9jiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F230A1C01;
	Mon,  3 Mar 2025 06:16:17 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B43663F66E;
	Mon,  3 Mar 2025 06:16:01 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/5] sparc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes
Date: Mon,  3 Mar 2025 14:15:38 +0000
Message-ID: <20250303141542.3371656-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303141542.3371656-1-ryan.roberts@arm.com>
References: <20250303141542.3371656-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 1a10a44dfc1d ("sparc64: implement the new page table range
API") set_ptes was added to the sparc architecture. The implementation
included calling arch_enter/leave_lazy_mmu() calls.

The patch removes the usage of arch_enter/leave_lazy_mmu() since this
implies nesting of lazy mmu regions which is not supported. Without this
fix, lazy mmu mode is effectively disabled because we exit the mode
after the first set_ptes:

remap_pte_range()
  -> arch_enter_lazy_mmu()
  -> set_ptes()
      -> arch_enter_lazy_mmu()
      -> arch_leave_lazy_mmu()
  -> arch_leave_lazy_mmu()

Powerpc suffered the same problem and fixed it in a corresponding way
with commit 47b8def9358c ("powerpc/mm: Avoid calling
arch_enter/leave_lazy_mmu() in set_ptes").

Cc: <stable@vger.kernel.org>
Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/sparc/include/asm/pgtable_64.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 2b7f358762c1..dc28f2c4eee3 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -936,7 +936,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	arch_enter_lazy_mmu_mode();
 	for (;;) {
 		__set_pte_at(mm, addr, ptep, pte, 0);
 		if (--nr == 0)
@@ -945,7 +944,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pte) += PAGE_SIZE;
 		addr += PAGE_SIZE;
 	}
-	arch_leave_lazy_mmu_mode();
 }
 #define set_ptes set_ptes
 
-- 
2.43.0

