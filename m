From: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
Date: Tue, 10 May 2011 23:53:26 +0000
Subject: [PATCH] sparc32/LEON: Added __init declaration to leon_flush_needed()
Message-Id: <4DC9CFF6.4020804@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function leon_flush_needed() is called only during bootup
from another __init function. Therefore, we can add
__init to leon_flush_needed().

Signed-off-by: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
---
  arch/sparc/mm/leon_mm.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index c0e0129..e485a68 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -226,7 +226,7 @@ void leon3_getCacheRegs(struct leon3_cacheregs *regs)
   * Leon2 and Leon3 differ in their way of telling cache information
   *
   */
-int leon_flush_needed(void)
+int __init leon_flush_needed(void)
  {
         int flush_needed = -1;
         unsigned int ssize, sets;
--
1.6.4.2
