From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 22 Feb 2013 13:19:07 +0000
Subject: [PATCH]sparc32: Fix lost pte_present() state while mprotect() system call
Message-Id: <1123991361539147@web6h.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If pte is present before change_pte_range() works on it, the state will be
lost after it. pte_modify() zeroes every 0xff bit including SRMMU_ET_MASK
while it adds new protection. I receive the stack after this (on a slightly
modified kernel):

BUG: Bad page map in process SC_EXE  pte:059d8cfc pmd:00069e01
addr:52d44000 vm_flags:00100070 anon_vma:be6ef3cc mapping:(null) index:52d44
8009e8d0 : zap_pte_range+0x120/0x3bc
8009ed3c : unmap_page_range+0x1d0/0x230
8009ee80 : unmap_vmas+0xe4/0x160
800a5a74 : exit_mmap+0xbc/0x218
8003ed24 : mmput+0x2c/0x100
80044190 : exit_mm+0x108/0x148
800447a0 : do_exit+0x158/0x350
80044a08 : do_group_exit+0x38/0xb8
80044a94 : sys_exit_group+0xc/0x1c
8001232c : syscall_is_too_hard+0x38/0x44
7fd5a7c4 : 0x7fd5a7c4

So, add SRMMU_ET_MASK to SRMMU_CHG_MASK.

Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pgtsrmmu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 79da178..5d33984 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -84,7 +84,7 @@
 
 #define SRMMU_PTE_FILE_SHIFT     8	/* = 32-PTE_FILE_MAX_BITS */
 
-#define SRMMU_CHG_MASK    (0xffffff00 | SRMMU_REF | SRMMU_DIRTY)
+#define SRMMU_CHG_MASK    (0xffffff00 | SRMMU_REF | SRMMU_DIRTY | SRMMU_ET_MASK)
 
 /* SRMMU swap entry encoding
  *
