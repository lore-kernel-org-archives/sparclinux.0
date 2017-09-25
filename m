From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Mon, 25 Sep 2017 16:48:59 +0000
Subject: [PATCH v8 8/9] mm: Clear arch specific VM flags on protection change
Message-Id: <9297528d3184e695e98129f4362a8f399b5783cf.1506089472.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1506089472.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1506089472.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, mhocko@suse.com, davem@davemloft.net, jack@suse.cz, kirill.shutemov@linux.intel.com, ross.zwisler@linux.intel.com, lstoakes@gmail.com, dave.jiang@intel.com, willy@infradead.org, hughd@google.com, ying.huang@intel.com, n-horiguchi@ah.jp.nec.com, heiko.carstens@de.ibm.com, mgorman@suse.de, aarcange@redhat.com, ak@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

When protection bits are changed on a VMA, some of the architecture
specific flags should be cleared as well. An examples of this are the
PKEY flags on x86. This patch expands the current code that clears
PKEY flags for x86, to support similar functionality for other
architectures as well.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
v7:
	- new patch

 include/linux/mm.h | 6 ++++++
 mm/mprotect.c      | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c1f6c95f3496..cbb21facce6b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -271,6 +271,12 @@ extern unsigned int kobjsize(const void *objp);
 /* This mask is used to clear all the VMA flags used by mlock */
 #define VM_LOCKED_CLEAR_MASK	(~(VM_LOCKED | VM_LOCKONFAULT))
 
+/* Arch-specific flags to clear when updating VM flags on protection change */
+#ifndef VM_ARCH_CLEAR
+# define VM_ARCH_CLEAR	VM_NONE
+#endif
+#define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4f0e46bb1797..85b65b3a823d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -453,7 +453,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		 * cleared from the VMA.
 		 */
 		mask_off_old_flags = VM_READ | VM_WRITE | VM_EXEC |
-					ARCH_VM_PKEY_FLAGS;
+					VM_FLAGS_CLEAR;
 
 		new_vma_pkey = arch_override_mprotect_pkey(vma, prot, pkey);
 		newflags = calc_vm_prot_bits(prot, new_vma_pkey);
-- 
2.11.0

