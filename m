From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 03 Dec 2018 15:47:13 +0000
Subject: [PATCH v2 4/6] openrisc: simplify pte_alloc_one_kernel()
Message-Id: <1543852035-26634-5-git-send-email-rppt@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

The pte_alloc_one_kernel() function allocates a page using
__get_free_page(GFP_KERNEL) when mm initialization is complete and
memblock_phys_alloc() on the earlier stages. The physical address of the
page allocated with memblock_phys_alloc() is converted to the virtual
address and in the both cases the allocated page is cleared using
clear_page().

The code is simplified by replacing __get_free_page() with
get_zeroed_page() and by replacing memblock_phys_alloc() with
memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/ioremap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index c969752..cfef989 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -123,13 +123,10 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm,
 {
 	pte_t *pte;
 
-	if (likely(mem_init_done)) {
-		pte = (pte_t *) __get_free_page(GFP_KERNEL);
-	} else {
-		pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-	}
+	if (likely(mem_init_done))
+		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
+	else
+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
-	if (pte)
-		clear_page(pte);
 	return pte;
 }
-- 
2.7.4
