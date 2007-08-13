From: joe@perches.com
Date: Mon, 13 Aug 2007 06:36:25 +0000
Subject: [PATCH] [452/2many] MAINTAINERS - UltraSPARC (sparc64):
Message-Id: <46bffbe9.HKclFFagHgDWmT4p%joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e6d5c86..52c9db7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4313,6 +4313,8 @@ M:	davem@davemloft.net
 L:	sparclinux@vger.kernel.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git
 S:	Maintained
+F:	arch/sparc64/
+F:	include/asm-sparc64/
 
 SHARP LH SUPPORT (LH7952X & LH7A40X)
 P:	Marc Singer
