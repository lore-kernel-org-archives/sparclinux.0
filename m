From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Wed, 15 Feb 2012 19:20:04 +0000
Subject: [PATCH] arch/sparc/kernel/unaligned_64.c: included linux/bitops.h twice
Message-Id: <1329333604-31883-1-git-send-email-danny.kukawka@bisect.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Danny Kukawka <dkukawka@suse.de>, Ingo Molnar <mingo@elte.hu>, Joe Perches <joe@perches.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

arch/sparc/kernel/unaligned_64.c included 'linux/bitops.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/sparc/kernel/unaligned_64.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 76e4ac1..626e7b0 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -22,7 +22,6 @@
 #include <linux/bitops.h>
 #include <linux/perf_event.h>
 #include <linux/ratelimit.h>
-#include <linux/bitops.h>
 #include <asm/fpumacro.h>
 
 enum direction {
-- 
1.7.8.3

