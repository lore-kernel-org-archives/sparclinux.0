From: Mike Rapoport <rppt@kernel.org>
Date: Mon, 04 Nov 2019 06:56:23 +0000
Subject: [PATCH v3 09/13] parisc/hugetlb: use pgtable-nopXd instead of 4level-fixup
Message-Id: <1572850587-20314-10-git-send-email-rppt@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1572850587-20314-1-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/parisc/mm/hugetlbpage.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d578809..0e1e212 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -49,6 +49,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
@@ -61,7 +62,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 	addr &= HPAGE_MASK;
 
 	pgd = pgd_offset(mm, addr);
-	pud = pud_alloc(mm, pgd, addr);
+	p4d = p4d_offset(pgd, addr);
+	pud = pud_alloc(mm, p4d, addr);
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, addr);
 		if (pmd)
@@ -74,6 +76,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte = NULL;
@@ -82,11 +85,14 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 
 	pgd = pgd_offset(mm, addr);
 	if (!pgd_none(*pgd)) {
-		pud = pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
-			pmd = pmd_offset(pud, addr);
-			if (!pmd_none(*pmd))
-				pte = pte_offset_map(pmd, addr);
+		p4d = p4d_offset(pgd, addr);
+		if (!p4d_none(*p4d)) {
+			pud = pud_offset(p4d, addr);
+			if (!pud_none(*pud)) {
+				pmd = pmd_offset(pud, addr);
+				if (!pmd_none(*pmd))
+					pte = pte_offset_map(pmd, addr);
+			}
 		}
 	}
 	return pte;
-- 
2.7.4
