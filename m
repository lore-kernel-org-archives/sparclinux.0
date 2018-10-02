From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 02 Oct 2018 10:19:54 +0000
Subject: [PATCH] sparc64: fix fall-through annotation
Message-Id: <20181002101954.GA645@embeddedor.com>
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
 arch/sparc/kernel/kgdb_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index d5f7dc6..a68bbddbd 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -148,7 +148,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 			linux_regs->tpc = addr;
 			linux_regs->tnpc = addr + 4;
 		}
-		/* fallthru */
+		/* fall through */
 
 	case 'D':
 	case 'k':
-- 
2.7.4
