From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 23 Jul 2020 23:15:41 +0000
Subject: [PATCH 0/3] Drop unused MAX_PHYSADDR_BITS
Message-Id: <20200723231544.17274-1-nivedita@alum.mit.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

This #define is not used anywhere, and has the wrong value on x86_64.

I tried digging into the history a bit, but it seems to have been unused
even in the initial merge of sparsemem in v2.6.13, when it was first
defined.

Arvind Sankar (3):
  x86/mm: Drop unused MAX_PHYSADDR_BITS
  sh/mm: Drop unused MAX_PHYSADDR_BITS
  sparc: Drop unused MAX_PHYSADDR_BITS

 arch/sh/include/asm/sparsemem.h    | 4 +---
 arch/sparc/include/asm/sparsemem.h | 1 -
 arch/x86/include/asm/sparsemem.h   | 6 +-----
 3 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.26.2
