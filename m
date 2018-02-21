From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 17:15:49 +0000
Subject: [PATCH v12 07/11] mm: Add address parameter to arch_validate_prot()
Message-Id: <349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, bsingharora@gmail.com, nborisov@suse.com, aarcange@redhat.com, anthony.yznaga@oracle.com, mgorman@suse.de, linuxram@us.ibm.com, kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, jack@suse.cz, ross.zwisler@linux.intel.com, gregkh@linuxfoundation.org, tglx@linutronix.de, mhocko@suse.com, n-horiguchi@ah.jp.nec.com, jglisse@redhat.com, henry.willard@oracle.com, aneesh.kumar@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

A protection flag may not be valid across entire address space and
hence arch_validate_prot() might need the address a protection bit is
being set on to ensure it is a valid protection flag. For example, sparc
processors support memory corruption detection (as part of ADI feature)
flag on memory addresses mapped on to physical RAM but not on PFN mapped
pages or addresses mapped on to devices. This patch adds address to the
parameters being passed to arch_validate_prot() so protection bits can
be validated in the relevant context.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v8:
	- Added addr parameter to powerpc arch_validate_prot() (suggested
	  by Michael Ellerman)
v9:
	- new patch

 arch/powerpc/include/asm/mman.h | 4 ++--
 arch/powerpc/kernel/syscalls.c  | 2 +-
 include/linux/mman.h            | 2 +-
 mm/mprotect.c                   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 07e3f54de9e3..e3f1b5ba5d5c 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -43,7 +43,7 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 }
 #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
-static inline bool arch_validate_prot(unsigned long prot)
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
 		return false;
@@ -51,7 +51,7 @@ static inline bool arch_validate_prot(unsigned long prot)
 		return false;
 	return true;
 }
-#define arch_validate_prot(prot) arch_validate_prot(prot)
+#define arch_validate_prot arch_validate_prot
 
 #endif /* CONFIG_PPC64 */
 #endif	/* _ASM_POWERPC_MMAN_H */
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index a877bf8269fe..6d90ddbd2d11 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -48,7 +48,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
 {
 	long ret = -EINVAL;
 
-	if (!arch_validate_prot(prot))
+	if (!arch_validate_prot(prot, addr))
 		goto out;
 
 	if (shift) {
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 6a4d1caaff5c..4b08e9c9c538 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -92,7 +92,7 @@ static inline void vm_unacct_memory(long pages)
  *
  * Returns true if the prot flags are valid
  */
-static inline bool arch_validate_prot(unsigned long prot)
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 {
 	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) = 0;
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e3309fcf586b..088ea9c08678 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -417,7 +417,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	end = start + len;
 	if (end <= start)
 		return -ENOMEM;
-	if (!arch_validate_prot(prot))
+	if (!arch_validate_prot(prot, start))
 		return -EINVAL;
 
 	reqprot = prot;
-- 
2.11.0

