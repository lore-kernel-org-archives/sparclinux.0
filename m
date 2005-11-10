From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 10 Nov 2005 20:49:21 +0000
Subject: Re: unknown symbol uts_sem in solaris.ko
Message-Id: <20051110.124921.88606945.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0511101508030.19615@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0511101508030.19615@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 10 Nov 2005 15:09:29 +0200 (EET)

> Maybe a result of recent changes to stop extra rebuilds when 
> only localversion changes - so only utsname is affected.

No, it's because the uts_sem module export got erroneously
removed, the author of that change didn't notice the sparc64
solaris module usage.  I'll re-export it as follows:

diff-tree 393b07258766130146b962bc294d66615a47468a (from a46699c9a32505cb5bbfd16f76e7d4a2c84a7705)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Thu Nov 10 12:47:50 2005 -0800

    [SPARC64]: Re-export uts_sem for solaris compat module.
    
    Revert: b26b9bc58263acda274f82a9dde8b6d96559878a
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/kernel/sys.c b/kernel/sys.c
index c43b3e2..bce933e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1497,6 +1497,8 @@ EXPORT_SYMBOL(in_egroup_p);
 
 DECLARE_RWSEM(uts_sem);
 
+EXPORT_SYMBOL(uts_sem);
+
 asmlinkage long sys_newuname(struct new_utsname __user * name)
 {
 	int errno = 0;
