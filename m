From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:56:45 +0000
Subject: [RFC 1/8] sparc: prom: Sanitize return value from prom_nbputchar()
Message-Id: <4CF9BBFD.70503@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BBC6.3080809@julian.is-a-geek.org>
In-Reply-To: <4CF9BBC6.3080809@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---

Sorry about the dupe, wrong from address.

 arch/sparc/prom/console_32.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
index 4886310..b05e3db 100644
--- a/arch/sparc/prom/console_32.c
+++ b/arch/sparc/prom/console_32.c
@@ -27,13 +27,14 @@ static int prom_nbputchar(const char *buf)
 	spin_lock_irqsave(&prom_lock, flags);
 	switch(prom_vers) {
 	case PROM_V0:
-		i = (*(romvec->pv_nbputchar))(*buf);
+		if ((*(romvec->pv_nbputchar))(*buf))
+			i = 1;
 		break;
 	case PROM_V2:
 	case PROM_V3:
 		if ((*(romvec->pv_v2devops).v2_dev_write)(*romvec->pv_v2bootargs.fd_stdout,
 							  buf, 0x1) = 1)
-			i = 0;
+			i = 1;
 		break;
 	default:
 		break;
@@ -47,7 +48,7 @@ void prom_console_write_buf(const char *buf, int len)
 {
 	while (len) {
 		int n = prom_nbputchar(buf);
-		if (n)
+		if (n < 0)
 			continue;
 		len--;
 		buf++;
