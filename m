From: ira.weiny@intel.com
Date: Mon, 18 May 2020 18:48:43 +0000
Subject: [PATCH] arch/{mips,sparc,microblaze,powerpc}: Don't enable pagefault/preempt twice
Message-Id: <20200518184843.3029640-1-ira.weiny@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-8-ira.weiny@intel.com>
In-Reply-To: <20200507150004.1423069-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

From: Ira Weiny <ira.weiny@intel.com>

The kunmap_atomic clean up failed to remove one set of pagefault/preempt
enables when vaddr is not in the fixmap.

Fixes: bee2128a09e6 ("arch/kunmap_atomic: consolidate duplicate code")
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/microblaze/mm/highmem.c | 5 +----
 arch/mips/mm/highmem.c       | 5 +----
 arch/powerpc/mm/highmem.c    | 5 +----
 arch/sparc/mm/highmem.c      | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/microblaze/mm/highmem.c b/arch/microblaze/mm/highmem.c
index ee8a422b2b76..92e0890416c9 100644
--- a/arch/microblaze/mm/highmem.c
+++ b/arch/microblaze/mm/highmem.c
@@ -57,11 +57,8 @@ void kunmap_atomic_high(void *kvaddr)
 	int type;
 	unsigned int idx;
 
-	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
-		pagefault_enable();
-		preempt_enable();
+	if (vaddr < __fix_to_virt(FIX_KMAP_END))
 		return;
-	}
 
 	type = kmap_atomic_idx();
 
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index 37e244cdb14e..8e8726992720 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -41,11 +41,8 @@ void kunmap_atomic_high(void *kvaddr)
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	int type __maybe_unused;
 
-	if (vaddr < FIXADDR_START) { // FIXME
-		pagefault_enable();
-		preempt_enable();
+	if (vaddr < FIXADDR_START)
 		return;
-	}
 
 	type = kmap_atomic_idx();
 #ifdef CONFIG_DEBUG_HIGHMEM
diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
index 35071c2913f1..624b4438aff9 100644
--- a/arch/powerpc/mm/highmem.c
+++ b/arch/powerpc/mm/highmem.c
@@ -44,11 +44,8 @@ void kunmap_atomic_high(void *kvaddr)
 {
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 
-	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
-		pagefault_enable();
-		preempt_enable();
+	if (vaddr < __fix_to_virt(FIX_KMAP_END))
 		return;
-	}
 
 	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) {
 		int type = kmap_atomic_idx();
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index d237d902f9c3..6ff6e2a9f9b3 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -86,11 +86,8 @@ void kunmap_atomic_high(void *kvaddr)
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	int type;
 
-	if (vaddr < FIXADDR_START) { // FIXME
-		pagefault_enable();
-		preempt_enable();
+	if (vaddr < FIXADDR_START)
 		return;
-	}
 
 	type = kmap_atomic_idx();
 
-- 
2.25.1
