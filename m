From: Mathias Krause <minipli@googlemail.com>
Date: Wed, 05 Apr 2017 19:24:20 +0000
Subject: [PATCH v2] sparc: remove unused wp_works_ok macro
Message-Id: <1491420260-32213-1-git-send-email-minipli@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, sparclinux@vger.kernel.org

It's unused for ages, used to be required for ksyms.c back in the v1.1
times.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
Hi Dave,

same patch as v1 but as the tip folks took only the x86 parts, I think,
this one should go through the SPARC tree.

Cheers,
Mathias

 arch/sparc/include/asm/processor_32.h |    6 ------
 arch/sparc/include/asm/processor_64.h |    4 ----
 2 files changed, 10 deletions(-)

diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 365d4cb267b4..dd27159819eb 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -18,12 +18,6 @@
 #include <asm/signal.h>
 #include <asm/page.h>
 
-/*
- * The sparc has no problems with write protection
- */
-#define wp_works_ok 1
-#define wp_works_ok__is_a_macro /* for versions in ksyms.c */
-
 /* Whee, this is STACK_TOP + PAGE_SIZE and the lowest kernel address too...
  * That one page is used to protect kernel from intruders, so that
  * we can make our access_ok test faster
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 6448cfc8292f..b58ee9018433 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -18,10 +18,6 @@
 #include <asm/ptrace.h>
 #include <asm/page.h>
 
-/* The sparc has no problems with write protection */
-#define wp_works_ok 1
-#define wp_works_ok__is_a_macro /* for versions in ksyms.c */
-
 /*
  * User lives in his very own context, and cannot reference us. Note
  * that TASK_SIZE is a misnomer, it really gives maximum user virtual
-- 
1.7.10.4

