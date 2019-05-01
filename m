From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 01 May 2019 19:56:15 +0000
Subject: [PATCH 1/3] arm: remove ARCH_SELECT_MEMORY_MODEL
Message-Id: <1556740577-4140-2-git-send-email-rppt@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

The ARCH_SELECT_MEMORY_MODEL in arch/arm/Kconfig is enabled only when
ARCH_SPARSEMEM_ENABLE=y. But in this case, ARCH_SPARSEMEM_DEFAULT is also
enabled and this in turn enables SPARSEMEM_MANUAL.

Since there is no definition of ARCH_FLATMEM_ENABLE in arch/arm/Kconfig,
SPARSEMEM_MANUAL is the only enabled memory model, hence the final
selection will evaluate to SPARSEMEM=y.

Since ARCH_SPARSEMEM_ENABLE is set to 'y' only by several sub-arch
configurations, the default for must sub-arches would be the falback to
FLATMEM regardless of ARCH_SELECT_MEMORY_MODEL.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9aed25a..25a69a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1592,9 +1592,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool ARCH_SPARSEMEM_ENABLE
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool ARCH_SPARSEMEM_ENABLE
-
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.7.4
