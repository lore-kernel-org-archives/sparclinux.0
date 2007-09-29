From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 29 Sep 2007 10:04:49 +0000
Subject: [PATCH] sparc64: check fork_idle() error
Message-Id: <20070929095856.GA4052@APFDCB5C>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Check the return value of fork_idle() to catch error.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 arch/sparc64/kernel/smp.c |    2 ++
 1 file changed, 2 insertions(+)

Index: 2.6-git/arch/sparc64/kernel/smp.c
=================================--- 2.6-git.orig/arch/sparc64/kernel/smp.c
+++ 2.6-git/arch/sparc64/kernel/smp.c
@@ -353,6 +353,8 @@ static int __devinit smp_boot_one_cpu(un
 	int timeout, ret;
 
 	p = fork_idle(cpu);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 	callin_flag = 0;
 	cpu_new_thread = task_thread_info(p);
 
