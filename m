From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 04 Dec 2010 03:57:19 +0000
Subject: [RFC 3/8] sparc: prom: Use n instead of len to decrement buf
Message-Id: <4CF9BC1F.6050800@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If the prom functions don't print the entire length of the buffer
we provide them, we should start over from where they finished,
rather than marking the entirety of the buffer as written.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---
 arch/sparc/prom/console_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index ed39e75..d4eb8ae 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -43,6 +43,6 @@ void prom_console_write_buf(const char *buf, int len)
 		if (n < 0)
 			continue;
 		len -= n;
-		buf += len;
+		buf += n;
 	}
 }
