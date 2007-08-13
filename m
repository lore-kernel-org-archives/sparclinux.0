From: joe@perches.com
Date: Mon, 13 Aug 2007 06:36:38 +0000
Subject: [PATCH] [457/2many] MAINTAINERS - SPARC (sparc32):
Message-Id: <46bffbf6.K2JGi26y4RBCa+g4%joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index aab0075..a91f3af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4362,6 +4362,8 @@ P:	William L. Irwin
 M:	wli@holomorphy.com
 L:	sparclinux@vger.kernel.org
 S:	Maintained
+F:	arch/sparc/
+F:	include/asm-sparc/
 
 SPECIALIX IO8+ MULTIPORT SERIAL CARD DRIVER
 P:	Roger Wolff
