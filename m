From: Andres Salomon <dilinger@queued.net>
Date: Tue, 29 Jun 2010 02:00:29 +0000
Subject: [PATCH 1/4] x86: OLPC: constify an olpc_ofw() arg
Message-Id: <20100628220029.1555ac24@debian>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian>
In-Reply-To: <20100628215407.2017bf2f@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, grant.likely@secretlab.ca


The arguments passed to OFW shouldn't be modified; update the 'args'
argument of olpc_ofw to reflect this.  This saves us some later
casting away of consts.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 arch/x86/include/asm/olpc_ofw.h |    2 +-
 arch/x86/kernel/olpc.c          |    2 +-
 arch/x86/kernel/olpc_ofw.c      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/olpc_ofw.h b/arch/x86/include/asm/olpc_ofw.h
index 3e63d85..08fde47 100644
--- a/arch/x86/include/asm/olpc_ofw.h
+++ b/arch/x86/include/asm/olpc_ofw.h
@@ -12,7 +12,7 @@
 #define olpc_ofw(name, args, res) \
 	__olpc_ofw((name), ARRAY_SIZE(args), args, ARRAY_SIZE(res), res)
 
-extern int __olpc_ofw(const char *name, int nr_args, void **args, int nr_res,
+extern int __olpc_ofw(const char *name, int nr_args, const void **args, int nr_res,
 		void **res);
 
 /* determine whether OFW is available and lives in the proper memory */
diff --git a/arch/x86/kernel/olpc.c b/arch/x86/kernel/olpc.c
index f5ff390..0e0cdde 100644
--- a/arch/x86/kernel/olpc.c
+++ b/arch/x86/kernel/olpc.c
@@ -188,7 +188,7 @@ static void __init platform_detect(void)
 {
 	size_t propsize;
 	__be32 rev;
-	void *args[] = { NULL, "board-revision-int", &rev, (void *)4 };
+	const void *args[] = { NULL, "board-revision-int", &rev, (void *)4 };
 	void *res[] = { &propsize };
 
 	if (olpc_ofw("getprop", args, res) || propsize != 4) {
diff --git a/arch/x86/kernel/olpc_ofw.c b/arch/x86/kernel/olpc_ofw.c
index deac703..3e13a4b 100644
--- a/arch/x86/kernel/olpc_ofw.c
+++ b/arch/x86/kernel/olpc_ofw.c
@@ -39,7 +39,7 @@ void __init setup_olpc_ofw_pgd(void)
 	/* implicit optimization barrier here due to uninline function return */
 }
 
-int __olpc_ofw(const char *name, int nr_args, void **args, int nr_res,
+int __olpc_ofw(const char *name, int nr_args, const void **args, int nr_res,
 		void **res)
 {
 	int ofw_args[MAXARGS + 3];
-- 
1.5.6.5

