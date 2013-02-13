From: David Miller <davem@davemloft.net>
Date: Wed, 13 Feb 2013 20:28:18 +0000
Subject: [PATCH 1/2] sparc64: Add missing HAVE_ARCH_TRANSPARENT_HUGEPAGE.
Message-Id: <20130213.152818.274813662879192793.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This got missed in the cleanups done for the S390 THP
support.

CC: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---

This is seriously brown-paper-bag material.

 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9f2edb5..cb9c333 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -61,6 +61,7 @@ config SPARC64
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_SYSCALL_WRAPPERS
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_SYSCALL_TRACEPOINTS
-- 
1.8.1.2

