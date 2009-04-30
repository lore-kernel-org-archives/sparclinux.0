From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 23:58:53 +0000
Subject: [PATCH 4/4] sparc: convert to new generic read_mostly support.
Message-Id: <1241135933-9913-5-git-send-email-tabbott@mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1241135933-9913-1-git-send-email-tabbott@mit.edu>
 <1241135933-9913-2-git-send-email-tabbott@mit.edu>
 <1241135933-9913-3-git-send-email-tabbott@mit.edu>
 <1241135933-9913-4-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135933-9913-4-git-send-email-tabbott@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/Kconfig             |    3 +++
 arch/sparc/include/asm/cache.h |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index cc12cd4..fbdeded 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -127,6 +127,9 @@ config OF
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y if SPARC64
 
+config HAVE_READ_MOSTLY_DATA
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
index 41f85ae..e614736 100644
--- a/arch/sparc/include/asm/cache.h
+++ b/arch/sparc/include/asm/cache.h
@@ -19,8 +19,6 @@
 
 #define SMP_CACHE_BYTES (1 << SMP_CACHE_BYTES_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data.read_mostly")))
-
 #ifdef CONFIG_SPARC32
 #include <asm/asi.h>
 
-- 
1.6.2.1

