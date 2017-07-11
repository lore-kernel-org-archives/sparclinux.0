From: Meelis Roos <mroos@linux.ee>
Date: Tue, 11 Jul 2017 11:48:27 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <alpine.LRH.2.20.1707111441480.31569@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

> I tested yesterdays git with 4.13 sparc merge on a big bunch of my test 
> machines.
> 
> Good news: the timestamps starting from boot seem to work on all the 
> machines, starting with Ultra 1 and Ultra 2.
> 
> Bad news: all working sun4u machines have the following line in dmesg 
> (PID varies):
> in:imklog[1036]: segfault at 49 ip 0000000000035bb0 (rpc 00000000f779dfa0) sp 00000002f7a78818 error 30002 in rsyslogd[10000+88000]
> 
> This is with Debian unstable 32-bit userland as of 2015 summer. It did 
> not happen with 4.12.

I bisected it to the commit below. CC Al Viro.

In following commits around this one (some bisect steps before, and the 
last step) the crashes were slightly different from the original crash 
yersterday, like

in:imuxsock[1606]: segfault at fffffff8 ip 00000000f774e154 (rpc 00000000f774dfe8) sp 00000001f7965a68 error 30002 in libc-2.19.so[f76cc000+16a000]

but this was the first commit introducing the crashes.

d9e968cb9f849770288f5fde3d8d3a5f7e339052 is the first bad commit
commit d9e968cb9f849770288f5fde3d8d3a5f7e339052
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed May 31 04:33:51 2017 -0400

    getrlimit()/setrlimit(): move compat to native

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

:040000 040000 5e1a0c25f4554ccdc824b18dc50078d379cdbf9a 
6d820451a388c5771a2a410578365d14a0194e4e M      kernel

-- 
Meelis Roos (mroos@linux.ee)
