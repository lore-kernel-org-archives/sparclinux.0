From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:48:56 +0000
Subject: [PATCH 1/3] sparc64: Support kmemleak.
Message-Id: <20100412.234856.177627643.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Only missing thing was an _sdata marker in vmlinux.lds.S

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/vmlinux.lds.S |    4 ++++
 lib/Kconfig.debug               |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index c4f5758..0c1e678 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -52,6 +52,10 @@ SECTIONS
 	_etext = .;
 
 	RO_DATA(PAGE_SIZE)
+
+	/* Start of data section */
+	_sdata = .;
+
 	.data1 : {
 		*(.data1)
 	}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1fafb4b..6c2be60 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -356,7 +356,7 @@ config SLUB_STATS
 config DEBUG_KMEMLEAK
 	bool "Kernel memory leak detector"
 	depends on DEBUG_KERNEL && EXPERIMENTAL && !MEMORY_HOTPLUG && \
-		(X86 || ARM || PPC || S390 || SUPERH)
+		(X86 || ARM || PPC || S390 || SPARC64 || SUPERH)
 
 	select DEBUG_FS if SYSFS
 	select STACKTRACE if STACKTRACE_SUPPORT
-- 
1.7.0.4

