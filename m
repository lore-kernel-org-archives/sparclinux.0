From: Sasha Levin <sashal@kernel.org>
Date: Sat, 26 Oct 2019 13:15:38 +0000
Subject: [PATCH AUTOSEL 5.3 77/99] sparc64: disable fast-GUP due to unexplained oopses
Message-Id: <20191026131600.2507-77-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry V Levin <ldv@altlinux.org>, Anatoly Pugachev <matorola@gmail.com>, Meelis Roos <mroos@linux.ee>, Christoph Hellwig <hch@infradead.org>, David Miller <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 8e0d0ad206f08506c893326ca7c9c3d9cc042cef ]

HAVE_FAST_GUP enables the lockless quick page table walker for simple
cases, and is a nice optimization for some random loads that can then
use get_user_pages_fast() rather than the more careful page walker.

However, for some unexplained reason, it seems to be subtly broken on
sparc64.  The breakage is only with some compiler versions and some
hardware, and nobody seems to have figured out what triggers it,
although there's a simple reprodicer for the problem when it does
trigger.

The problem was introduced with the conversion to the generic GUP code
in commit 7b9afb86b632 ("sparc64: use the generic get_user_pages_fast
code"), but nothing looks obviously wrong in that conversion.  It may be
a compiler bug that just hits us with the code reorganization.  Or it
may be something very specific to sparc64.

This disables HAVE_FAST_GUP entirely.  That makes things like futexes a
bit slower, but at least they work.  If we can figure out the trigger,
that would be lovely, but it's been three months already..

Link: https://lore.kernel.org/lkml/20190717215956.GA30369@altlinux.org/
Fixes: 7b9afb86b632 ("sparc64: use the generic get_user_pages_fast code")
Reported-by: Dmitry V Levin <ldv@altlinux.org>
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Requested-by: Meelis Roos <mroos@linux.ee>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7926a2e11bdc2..6a31f240840d4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -28,7 +28,6 @@ config SPARC
 	select RTC_DRV_M48T59
 	select RTC_SYSTOHC
 	select HAVE_ARCH_JUMP_LABEL if SPARC64
-	select HAVE_FAST_GUP if SPARC64
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select GENERIC_PCI_IOMAP
-- 
2.20.1
