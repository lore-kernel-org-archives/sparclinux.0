From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Wed, 12 Jul 2017 03:59:45 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <20170712035945.GA13102@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
 <alpine.LRH.2.20.1707111441480.31569@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707111441480.31569@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

> In following commits around this one (some bisect steps before, and the 
> last step) the crashes were slightly different from the original crash 
> yersterday, like
> 
> in:imuxsock[1606]: segfault at fffffff8 ip 00000000f774e154 (rpc 00000000f774dfe8) sp 00000001f7965a68 error 30002 in libc-2.19.so[f76cc000+16a000]
> 
> but this was the first commit introducing the crashes.
> 
> d9e968cb9f849770288f5fde3d8d3a5f7e339052 is the first bad commit
> commit d9e968cb9f849770288f5fde3d8d3a5f7e339052
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Wed May 31 04:33:51 2017 -0400
> 
w     getrlimit()/setrlimit(): move compat to native
> 
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> :040000 040000 5e1a0c25f4554ccdc824b18dc50078d379cdbf9a 
> 6d820451a388c5771a2a410578365d14a0194e4e M      kernel
> 
> -- 
> Meelis Roos (mroos@linux.ee)

With apologies for ed scripts,

ed kernel/sys.c <<'EOF'
/struct rlimit r32/s/rlimit/compat_&/
w
q
EOF

AFAICS, that should fix it.  If it does, commit message would be

fix a braino in compat_sys_getrlimit()

Fixes: commit d9e968cb9f84 "getrlimit()/setrlimit(): move compat to native"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

Again, my apologies for format of that all - I'm almost completely
off-net and while typing an ed script is feasible, context diff is
too far over the top.  Usimg mutt in ssh session from android is
not fun, to put it mildly...  
