From: Clemens Buchacher <drizzd@aon.at>
Date: Fri, 08 Oct 2004 14:55:56 +0000
Subject: [patch] [SPARC]: Fix warning for changed section attributes
Message-Id: <20041008145556.GA11450@kzelldran.lan>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: "Keith M. Wesolowsi" <wesolows@foobazco.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

This fixes the "Ignoring changed section attributes" warning by commenting out
the attributes appended by gcc.

The previous 'fix' created a section '.text,#alloc' (literally), which I guess
was not intended.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Runtime tested (Leon2 TSIM SPARC simulation)

 arch/sparc/kernel/init_task.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/kernel/init_task.c	2004-10-06 20:19:25 +02:00
+++ b/arch/sparc/kernel/init_task.c	2004-10-06 20:19:25 +02:00
@@ -23,6 +23,6 @@
  * in etrap.S which assumes it.
  */
 union thread_union init_thread_union
-	__attribute__((section (".text,#alloc")))
+	__attribute__((section (".text\"\n\t#")))
 	__attribute__((aligned (THREAD_SIZE)))
 	= { INIT_THREAD_INFO(init_task) };
