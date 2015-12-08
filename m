From: Yang Shi <yang.shi@linaro.org>
Date: Tue, 08 Dec 2015 19:39:55 +0000
Subject: [PATCH v3 7/7] sparc64: mm/gup: add gup trace points
Message-Id: <1449603595-718-8-git-send-email-yang.shi@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1449603595-718-1-git-send-email-yang.shi@linaro.org>
In-Reply-To: <1449603595-718-1-git-send-email-yang.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linaro-kernel@lists.linaro.org, yang.shi@linaro.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/sparc/mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index 2e5c4fc..d364cc6 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -12,6 +12,9 @@
 #include <linux/rwsem.h>
 #include <asm/pgtable.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 /*
  * The performance critical leaf functions are made noinline otherwise gcc
  * inlines everything into a single function which results in too much
@@ -174,6 +177,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
+	trace_gup_get_user_pages_fast(start, (unsigned long) nr_pages);
+
 	local_irq_save(flags);
 	pgdp = pgd_offset(mm, addr);
 	do {
@@ -236,6 +241,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	local_irq_enable();
 
+	trace_gup_get_user_pages_fast(start, (unsigned long) nr_pages);
+
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
 
-- 
2.0.2

