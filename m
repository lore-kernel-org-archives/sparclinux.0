From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Sun, 10 Feb 2008 20:05:34 +0000
Subject: [PATCH] SPARC:  Use shorter form of "get_zeroed_page".
Message-Id: <alpine.LFD.1.00.0802101504130.14909@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  AFIACT, this should be equivalent, no?  and shorter.

diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index c0442e8..2375fe9 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -1941,9 +1941,7 @@ static pte_t *sun4c_pte_alloc_one_kernel(struct mm_struct *mm, unsigned long add
 	if ((pte = sun4c_pte_alloc_one_fast(mm, address)) != NULL)
 		return pte;

-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	if (pte)
-		memset(pte, 0, PAGE_SIZE);
+	pte = (pte_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
 	return pte;
 }

====================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

Home page:                                         http://crashcourse.ca
Fedora Cookbook:    http://crashcourse.ca/wiki/index.php/Fedora_Cookbook
====================================
