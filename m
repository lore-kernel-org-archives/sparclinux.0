From: Alexandre Ghiti <alex@ghiti.fr>
Date: Wed, 27 Mar 2019 06:36:23 +0000
Subject: [PATCH v8 1/4] sh: Advertise gigantic page support
Message-Id: <20190327063626.18421-2-alex@ghiti.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20190327063626.18421-1-alex@ghiti.fr>
In-Reply-To: <20190327063626.18421-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
Cc: Alexandre Ghiti <alex@ghiti.fr>

sh actually supports gigantic pages and selecting
ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
gigantic pages at runtime.

At least sdk7786_defconfig exposes such a configuration with
huge pages of 64MB, pages of 4KB and MAX_ORDER = 11:
HPAGE_SHIFT (26) - PAGE_SHIFT (12) = 14 >= MAX_ORDER (11)

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b1c91ea9a958..0d9fb2468e0b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -53,6 +53,7 @@ config SUPERH
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
 	select NEED_SG_DMA_LENGTH
+	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
-- 
2.20.1
