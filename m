From: Yang Shi <yang.shi@linaro.org>
Date: Tue, 01 Dec 2015 23:06:17 +0000
Subject: [PATCH 7/7] sparc64: mm/gup: add gup trace points
Message-Id: <1449011177-30686-8-git-send-email-yang.shi@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1449011177-30686-1-git-send-email-yang.shi@linaro.org>
In-Reply-To: <1449011177-30686-1-git-send-email-yang.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linaro-kernel@lists.linaro.org, yang.shi@linaro.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
The context depends on the below patch:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1028752.html

 arch/sparc/mm/gup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index cf4fb47..6dcfc4d 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -10,6 +10,10 @@
 #include <linux/vmstat.h>
 #include <linux/pagemap.h>
 #include <linux/rwsem.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 #include <asm/pgtable.h>
 
 /*
@@ -177,6 +181,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					(void __user *)start, len)))
 		return 0;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	local_irq_save(flags);
 	pgdp = pgd_offset(mm, addr);
 	do {
@@ -209,6 +215,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (end < start)
 		goto slow_irqon;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
 	 * needs some instrumenting to determine the common sizes used by
-- 
2.0.2

