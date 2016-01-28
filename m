From: Jeffrey Merkey <jeffmerkey@gmail.com>
Date: Thu, 28 Jan 2016 19:47:48 +0000
Subject: [PATCH 30/31] Add debugger entry points for SPARC
Message-Id: <1454010468-29651-1-git-send-email-jeffmerkey@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, linux.mdb@gmail.com, sparclinux@vger.kernel.org

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/sparc/include/asm/kdebug.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sparc/include/asm/kdebug.h b/arch/sparc/include/asm/kdebug.h
index 8d12581..a4b78d3 100644
--- a/arch/sparc/include/asm/kdebug.h
+++ b/arch/sparc/include/asm/kdebug.h
@@ -5,4 +5,9 @@
 #else
 #include <asm/kdebug_32.h>
 #endif
+
+static inline void arch_breakpoint(void)
+{
+	asm("ta	$0x7d");
+}
 #endif
-- 
1.8.3.1

