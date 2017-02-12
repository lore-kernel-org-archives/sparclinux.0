From: Mathias Krause <minipli@googlemail.com>
Date: Sun, 12 Feb 2017 21:12:10 +0000
Subject: [PATCH 4/6] sparc: remove unused wp_works_ok macro
Message-Id: <1486933932-585-5-git-send-email-minipli@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1486933932-585-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1486933932-585-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, Jesper Nilsson <jesper.nilsson@axis.com>, Mikael Starvik <starvik@axis.com>, Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, sparclinux@vger.kernel.org

It's unused for ages, used to be required for ksyms.c back in the v1.1
times.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
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

