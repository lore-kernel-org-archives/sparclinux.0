From: Michel Lespinasse <walken@google.com>
Date: Mon, 05 Nov 2012 22:47:04 +0000
Subject: [PATCH 07/16] mm: fix cache coloring on x86_64 architecture
Message-Id: <1352155633-8648-8-git-send-email-walken@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Fix the x86-64 cache alignment code to take pgoff into account.
Use the x86 and MIPS cache alignment code as the basis for a generic
cache alignment function.

The old x86 code will always align the mmap to aliasing boundaries,
even if the program mmaps the file with a non-zero pgoff.

If program A mmaps the file with pgoff 0, and program B mmaps the
file with pgoff 1. The old code would align the mmaps, resulting in
misaligned pages:

A:  0123
B:  123

After this patch, they are aligned so the pages line up:

A: 0123
B:  123

Signed-off-by: Michel Lespinasse <walken@google.com>
Proposed-by: Rik van Riel <riel@redhat.com>

---
 arch/x86/kernel/sys_x86_64.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index f00d006d60fd..97ef74b88e0f 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -136,7 +136,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = begin;
 	info.high_limit = end;
 	info.align_mask = filp ? get_align_mask() : 0;
-	info.align_offset = 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
 
@@ -175,7 +175,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	info.align_mask = filp ? get_align_mask() : 0;
-	info.align_offset = 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
 		return addr;
-- 
1.7.7.3
