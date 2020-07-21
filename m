From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 21 Jul 2020 21:00:33 +0000
Subject: [PATCH] SPARC: backoff.h: delete a duplicated word
Message-Id: <20200721210033.15408-1-rdunlap@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Drop the repeated word "other".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
@David:
In arch/sparc/include/asm/cpu_type.h, line 12,
is that duplicated "ploos" correct?
  sun4u       = 0x03, /* V8 ploos ploos */

 arch/sparc/include/asm/backoff.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/sparc/include/asm/backoff.h
+++ linux-next-20200720/arch/sparc/include/asm/backoff.h
@@ -18,7 +18,7 @@
  *
  * When we spin, we try to use an operation that will cause the
  * current cpu strand to block, and therefore make the core fully
- * available to any other other runnable strands.  There are two
+ * available to any other runnable strands.  There are two
  * options, based upon cpu capabilities.
  *
  * On all cpus prior to SPARC-T4 we do three dummy reads of the
