From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:56:09 +0000
Subject: [RFC 2/8] sparc: prom: Use the return value from prom_nbputchar()
Message-Id: <4CF9BBD9.2090403@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

As prom_nbputchar() now returns 1 when it succeeds, use it instead
of decrementing len or incrementing buf - as this matches the
behaviour of prom_console_write_buf() in console_64.c

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---
 arch/sparc/prom/console_32.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
index b05e3db..055368a 100644
--- a/arch/sparc/prom/console_32.c
+++ b/arch/sparc/prom/console_32.c
@@ -50,8 +50,7 @@ void prom_console_write_buf(const char *buf, int len)
 		int n = prom_nbputchar(buf);
 		if (n < 0)
 			continue;
-		len--;
-		buf++;
+		len -= n;
+		buf += n;
 	}
 }
-
