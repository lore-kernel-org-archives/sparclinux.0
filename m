From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:59:00 +0000
Subject: [RFC 4/8] sparc: prom: Remove unused definition of prom_stdin
Message-Id: <4CF9BC84.70905@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BC2E.9050300@julian.is-a-geek.org>
In-Reply-To: <4CF9BC2E.9050300@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---

er, same again. Sorry about this, I haven't done it in a while =)

 arch/sparc/prom/console_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index d4eb8ae..d66b98c 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -13,7 +13,7 @@
 #include <asm/system.h>
 #include <linux/string.h>
 
-extern int prom_stdin, prom_stdout;
+extern int prom_stdout;
 
 static int __prom_console_write_buf(const char *buf, int len)
 {
