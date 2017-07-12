From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jul 2017 04:09:02 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <20170711.210902.2170111857155619221.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
        <alpine.LRH.2.20.1707111441480.31569@math.ut.ee>
        <20170712035945.GA13102@ZenIV.linux.org.uk>
In-Reply-To: <20170712035945.GA13102@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 12 Jul 2017 04:59:45 +0100

> Again, my apologies for format of that all - I'm almost completely
> off-net and while typing an ed script is feasible, context diff is
> too far over the top.  Usimg mutt in ssh session from android is
> not fun, to put it mildly...  

Yes, that might be it.

Meelis, please test this:

==========
fix a braino in compat_sys_getrlimit()

Fixes: commit d9e968cb9f84 "getrlimit()/setrlimit(): move compat to native"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: David S. Miller <davem@davemloft.net>

diff --git a/kernel/sys.c b/kernel/sys.c
index 73fc0af..2855ee7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1362,7 +1362,7 @@ COMPAT_SYSCALL_DEFINE2(getrlimit, unsigned int, resource,
 
 	ret = do_prlimit(current, resource, NULL, &r);
 	if (!ret) {
-		struct rlimit r32;
+		struct compat_rlimit r32;
 		if (r.rlim_cur > COMPAT_RLIM_INFINITY)
 			r32.rlim_cur = COMPAT_RLIM_INFINITY;
 		else
