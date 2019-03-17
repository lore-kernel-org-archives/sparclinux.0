From: Alexandre Ghiti <alex@ghiti.fr>
Date: Sun, 17 Mar 2019 16:28:45 +0000
Subject: [PATCH v7 2/4] sparc: Advertise gigantic page support
Message-Id: <20190317162847.14107-3-alex@ghiti.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20190317162847.14107-1-alex@ghiti.fr>
In-Reply-To: <20190317162847.14107-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
Cc: Alexandre Ghiti <alex@ghiti.fr>

sparc actually supports gigantic pages and selecting
ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
gigantic pages at runtime.

sparc allows configuration such as huge pages of 16GB,
pages of 8KB and MAX_ORDER = 13 (default):
HPAGE_SHIFT (34) - PAGE_SHIFT (13) = 21 >= MAX_ORDER (13)

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index d5dd652fb8cc..0b7f0e0fefa5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -90,6 +90,7 @@ config SPARC64
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
+	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 
 config ARCH_DEFCONFIG
 	string
-- 
2.20.1
