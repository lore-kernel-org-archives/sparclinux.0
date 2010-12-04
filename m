From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:59:26 +0000
Subject: [RFC 7/8] sparc: prom: Make prom_console_write_buf() static
Message-Id: <4CF9BC9E.40409@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---
 arch/sparc/prom/printf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/prom/printf.c b/arch/sparc/prom/printf.c
index 590b985..187e2fa 100644
--- a/arch/sparc/prom/printf.c
+++ b/arch/sparc/prom/printf.c
@@ -82,7 +82,7 @@ static int __prom_console_write_buf(const char *buf, int len)
 
 #endif
 
-void prom_console_write_buf(const char *buf, int len)
+static void prom_console_write_buf(const char *buf, int len)
 {
 	while (len) {
 		int n = __prom_console_write_buf(buf, len);
