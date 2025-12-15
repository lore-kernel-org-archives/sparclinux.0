Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA03B33375C;
	Mon, 15 Dec 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811047; cv=none; b=QFiGQIPjmXYFUBAMj118JFy81f1p1vSb4d8gc8w69YTupM2fzcwI1K4MblJHnutt2ARncyc5nrzOpjY484fsCEbNLRXI8tcMqhmwFLOP5FoQapHZkqhCPEk5PIA8tMzVXB1X8emBUoscJru1AAm44b9KtNrRR8xyUwKyyQdTREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811047; c=relaxed/simple;
	bh=ZQ1iti6W8jPqW5TKHNxB7bKJihvjMjTws70qh7QOsa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLzHh71q4MNxTL+jfDSzkS8wWkD6BiCWINsZjPkpd7cn0xXkHP2q0tF5os2TQYr70Pc1zsAUnqV2dQKJf2FxLVu2Ap7t8Kj+vIBGj3/wBOhpgxTUbc/vZ/+j6xVW1qmdPj6me9qDvN2EvcHHPjo+DoAFrvye8XsrMMfZXahaSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B751168F;
	Mon, 15 Dec 2025 07:03:58 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A0493F73B;
	Mon, 15 Dec 2025 07:04:00 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Juergen Gross <jgross@suse.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org
Subject: [PATCH v6 05/14] mm: clarify lazy_mmu sleeping constraints
Date: Mon, 15 Dec 2025 15:03:14 +0000
Message-ID: <20251215150323.2218608-6-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251215150323.2218608-1-kevin.brodsky@arm.com>
References: <20251215150323.2218608-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lazy MMU mode documentation makes clear that an implementation
should not assume that preemption is disabled or any lock is held
upon entry to the mode; however it says nothing about what code
using the lazy MMU interface should expect.

In practice sleeping is forbidden (for generic code) while the lazy
MMU mode is active: say it explicitly.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/pgtable.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 652f287c1ef6..1abc4a1c3d72 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -225,11 +225,15 @@ static inline int pmd_dirty(pmd_t pmd)
  * up to date.
  *
  * In the general case, no lock is guaranteed to be held between entry and exit
- * of the lazy mode. So the implementation must assume preemption may be enabled
- * and cpu migration is possible; it must take steps to be robust against this.
- * (In practice, for user PTE updates, the appropriate page table lock(s) are
- * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
- * and the mode cannot be used in interrupt context.
+ * of the lazy mode. (In practice, for user PTE updates, the appropriate page
+ * table lock(s) are held, but for kernel PTE updates, no lock is held).
+ * The implementation must therefore assume preemption may be enabled upon
+ * entry to the mode and cpu migration is possible; it must take steps to be
+ * robust against this. An implementation may handle this by disabling
+ * preemption, as a consequence generic code may not sleep while the lazy MMU
+ * mode is active.
+ *
+ * Nesting is not permitted and the mode cannot be used in interrupt context.
  */
 #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void) {}
-- 
2.51.2

