From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 02 Oct 2018 10:15:17 +0000
Subject: [PATCH] sparc32: fix fall-through annotation
Message-Id: <20181002101517.GA32181@embeddedor.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/sparc/kernel/kgdb_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index 5868fc3..639c8e5 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -122,7 +122,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 			linux_regs->pc = addr;
 			linux_regs->npc = addr + 4;
 		}
-		/* fallthru */
+		/* fall through */
 
 	case 'D':
 	case 'k':
-- 
2.7.4
