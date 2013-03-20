From: David Miller <davem@davemloft.net>
Date: Wed, 20 Mar 2013 19:09:49 +0000
Subject: [PATCH] sparc64: Kill __ARCH_WANT_UNLOCKED_CTXSW
Message-Id: <20130320.150949.311835128213660395.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


As Peter Z. explained at:

https://lkml.org/lkml/2011/12/12/268

it's not needed at all and I even tested it back then.
This patch just got lost in the shuffle for some reason.

Reported-by: Kirill Tkhai <tkhai@yandex.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/processor_64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index cce72ce..4c3f7f0 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -18,9 +18,6 @@
 #include <asm/ptrace.h>
 #include <asm/page.h>
 
-/* Don't hold the runqueue lock over context switch */
-#define __ARCH_WANT_UNLOCKED_CTXSW
-
 /* The sparc has no problems with write protection */
 #define wp_works_ok 1
 #define wp_works_ok__is_a_macro /* for versions in ksyms.c */
-- 
1.7.11.7

