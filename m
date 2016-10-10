From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Mon, 10 Oct 2016 18:12:02 +0000
Subject: [PATCH 1/6] sparc64: Add FORCE_MAX_ZONEORDER and default to 13
Message-Id: <1476123127-24314-2-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, rkuo@codeaurora.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>

This change allows ATU (new IOMMU) in SPARC systems to request
large (32M) contiguous memory during boot for creating IOTSB backing
store.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
---
 arch/sparc/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f5d60f1..a7482bc 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -90,6 +90,10 @@ config ARCH_DEFCONFIG
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config ARCH_ATU
+	bool
+	default y if SPARC64
+
 config IOMMU_HELPER
 	bool
 	default y if SPARC64
@@ -305,6 +309,20 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y if SPARC64
 
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	default "13"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 13 means that the largest free memory block is 2^12 pages.
+
 source "mm/Kconfig"
 
 if SPARC64
-- 
1.9.1

