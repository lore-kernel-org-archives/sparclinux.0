From: Alexandre Ghiti <alex@ghiti.fr>
Date: Thu, 20 Jun 2019 05:03:25 +0000
Subject: [PATCH RESEND 5/8] mm: Start fallback top-down mmap at mm->mmap_base
Message-Id: <20190620050328.8942-6-alex@ghiti.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20190620050328.8942-1-alex@ghiti.fr>
In-Reply-To: <20190620050328.8942-1-alex@ghiti.fr>
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
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dedae10cb6e2..e563145c1ff4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2185,7 +2185,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	if (offset_in_page(addr)) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
+		info.low_limit = arch_get_mmap_base(addr, mm->mmap_base);
 		info.high_limit = mmap_end;
 		addr = vm_unmapped_area(&info);
 	}
-- 
2.20.1
