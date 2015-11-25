From: Yang Shi <yang.shi@linaro.org>
Date: Wed, 25 Nov 2015 22:45:43 +0000
Subject: [V2 PATCH] sparc64/gup: check address scope legitimacy
Message-Id: <1448491543-17946-1-git-send-email-yang.shi@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1448490684-17171-1-git-send-email-yang.shi@linaro.org>
In-Reply-To: <1448490684-17171-1-git-send-email-yang.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linaro-kernel@lists.linaro.org, yang.shi@linaro.org

Check if user address is accessible in atomic version __get_user_pages_fast()
before walking the page table.
And, check if end > start in get_user_pages_fast(), otherwise fallback to slow
path.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
Just found slow_irqon label is not defined, added it to avoid compile error.

 arch/sparc/mm/gup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index 2e5c4fc..cf4fb47 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -173,6 +173,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	addr = start;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
+	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
+					(void __user *)start, len)))
+		return 0;
 
 	local_irq_save(flags);
 	pgdp = pgd_offset(mm, addr);
@@ -203,6 +206,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	addr = start;
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
+	if (end < start)
+		goto slow_irqon;
 
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
@@ -244,7 +249,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 slow:
 		local_irq_enable();
-
+slow_irqon:
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
 		pages += nr;
-- 
2.0.2

