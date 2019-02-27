From: Steven Price <steven.price@arm.com>
Date: Wed, 27 Feb 2019 17:05:54 +0000
Subject: [PATCH v3 20/34] sparc: mm: Add p?d_large() definitions
Message-Id: <20190227170608.27963-21-steven.price@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190227170608.27963-1-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For sparc, we don't support large pages, so add stubs returning 0.

CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/sparc/include/asm/pgtable_32.h | 10 ++++++++++
 arch/sparc/include/asm/pgtable_64.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 4eebed6c6781..dbc533e4c460 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -177,6 +177,11 @@ static inline int pmd_none(pmd_t pmd)
 	return !pmd_val(pmd);
 }
 
+static inline int pmd_large(pmd_t pmd)
+{
+	return 0;
+}
+
 static inline void pmd_clear(pmd_t *pmdp)
 {
 	int i;
@@ -199,6 +204,11 @@ static inline int pgd_present(pgd_t pgd)
 	return ((pgd_val(pgd) & SRMMU_ET_MASK) = SRMMU_ET_PTD);
 }
 
+static inline int pgd_large(pgd_t pgd)
+{
+	return 0;
+}
+
 static inline void pgd_clear(pgd_t *pgdp)
 {
 	set_pte((pte_t *)pgdp, __pte(0));
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1393a8ac596b..c32b26bdea53 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -892,6 +892,7 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 #define pgd_page_vaddr(pgd)		\
 	((unsigned long) __va(pgd_val(pgd)))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0U)
+#define pgd_large(pgd)			(0)
 #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
 
 static inline unsigned long pud_large(pud_t pud)
-- 
2.20.1
