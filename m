From: Stoyan Gaydarov <stoyboyker@gmail.com>
Date: Tue, 10 Mar 2009 05:10:33 +0000
Subject: [PATCH 08/25] [sparc] BUG to BUG_ON changes
Message-Id: <1236661850-8237-9-git-send-email-stoyboyker@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1236661850-8237-1-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-2-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-3-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-4-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-5-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-6-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-7-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-8-git-send-email-stoyboyker@gmail.com>
In-Reply-To: <1236661850-8237-8-git-send-email-stoyboyker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Stoyan Gaydarov <stoyboyker@gmail.com>, davem@davemloft.net, sparclinux@vger.kernel.org

Signed-off-by: Stoyan Gaydarov <stoyboyker@gmail.com>
---
 arch/sparc/kernel/traps_64.c |    3 +--
 arch/sparc/lib/bitext.c      |   17 +++++++----------
 arch/sparc/mm/srmmu.c        |    3 +--
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index d809c4e..5cd6b4c 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -366,8 +366,7 @@ static void spitfire_clean_and_reenable_l1_caches(void)
 {
 	unsigned long va;
 
-	if (tlb_type != spitfire)
-		BUG();
+	BUG_ON(tlb_type != spitfire);
 
 	/* Clean 'em. */
 	for (va =  0; va < (PAGE_SIZE << 1); va += 32) {
diff --git a/arch/sparc/lib/bitext.c b/arch/sparc/lib/bitext.c
index 764b3eb..bc1007e 100644
--- a/arch/sparc/lib/bitext.c
+++ b/arch/sparc/lib/bitext.c
@@ -41,12 +41,11 @@ int bit_map_string_get(struct bit_map *t, int len, int align)
 			align = 1;
 	}
 	align1 = align - 1;
-	if ((align & align1) != 0)
-		BUG();
-	if (align < 0 || align >= t->size)
-		BUG();
-	if (len <= 0 || len > t->size)
-		BUG();
+
+	BUG_ON((align & align1) != 0);
+	BUG_ON(align < 0 || align >= t->size);
+	BUG_ON(len <= 0 || len > t->size);
+
 	color &= align1;
 
 	spin_lock(&t->lock);
@@ -104,8 +103,7 @@ void bit_map_clear(struct bit_map *t, int offset, int len)
 {
 	int i;
 
-	if (t->used < len)
-		BUG();		/* Much too late to do any good, but alas... */
+	BUG_ON(t->used < len);	/* Much too late to do any good, but alas... */
 	spin_lock(&t->lock);
 	for (i = 0; i < len; i++) {
 		if (test_bit(offset + i, t->map) = 0)
@@ -121,8 +119,7 @@ void bit_map_clear(struct bit_map *t, int offset, int len)
 void bit_map_init(struct bit_map *t, unsigned long *map, int size)
 {
 
-	if ((size & 07) != 0)
-		BUG();
+	BUG_ON((size & 07) != 0);
 	memset(map, 0, size>>3);
 
 	memset(t, 0, sizeof *t);
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index fe7ed08..5ea4dab 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -513,8 +513,7 @@ static void srmmu_pte_free(pgtable_t pte)
 
 	pgtable_page_dtor(pte);
 	p = (unsigned long)page_address(pte);	/* Cached address (for test) */
-	if (p = 0)
-		BUG();
+	BUG_ON(p = 0);
 	p = page_to_pfn(pte) << PAGE_SHIFT;	/* Physical address */
 	p = (unsigned long) __nocache_va(p);	/* Nocached virtual */
 	srmmu_free_nocache(p, PTE_SIZE);
-- 
1.6.1.3

