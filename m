From: Alexandre Ghiti <alex@ghiti.fr>
Date: Wed, 19 Jun 2019 05:08:40 +0000
Subject: [PATCH 4/8] x86, hugetlbpage: Start fallback of top-down mmap at mm->mmap_base
Message-Id: <20190619050844.5294-5-alex@ghiti.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20190619050844.5294-1-alex@ghiti.fr>
In-Reply-To: <20190619050844.5294-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Alexandre Ghiti <alex@ghiti.fr>

In case of mmap failure in top-down mode, there is no need to go through
the whole address space again for the bottom-up fallback: the goal of this
fallback is to find, as a last resort, space between the top-down mmap base
and the stack, which is the only place not covered by the top-down mmap.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/x86/mm/hugetlbpage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index fab095362c50..4b90339aef50 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -106,11 +106,12 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 {
 	struct hstate *h = hstate_file(file);
 	struct vm_unmapped_area_info info;
+	unsigned long mmap_base = get_mmap_base(0);
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
-	info.high_limit = get_mmap_base(0);
+	info.high_limit = mmap_base;
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -132,7 +133,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	if (addr & ~PAGE_MASK) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
+		info.low_limit = mmap_base;
 		info.high_limit = TASK_SIZE_LOW;
 		addr = vm_unmapped_area(&info);
 	}
-- 
2.20.1
