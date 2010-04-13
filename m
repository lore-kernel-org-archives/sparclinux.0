From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:42:42 +0000
Subject: [PATCH 3/7] sparc64: Kill unnecessary static on local var in
Message-Id: <20100412.234242.117720616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ftrace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index 9103a56..2ea6e4f 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -13,7 +13,7 @@ static const u32 ftrace_nop = 0x01000000;
 
 static u32 ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
-	static u32 call;
+	u32 call;
 	s32 off;
 
 	off = ((s32)addr - (s32)ip);
-- 
1.7.0.4

