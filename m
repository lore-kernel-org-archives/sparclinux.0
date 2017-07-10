From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Jul 2017 08:25:51 +0000
Subject: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tested yesterdays git with 4.13 sparc merge on a big bunch of my test 
machines.

Good news: the timestamps starting from boot seem to work on all the 
machines, starting with Ultra 1 and Ultra 2.

Bad news: all working sun4u machines have the following line in dmesg 
(PID varies):
in:imklog[1036]: segfault at 49 ip 0000000000035bb0 (rpc 00000000f779dfa0) sp 00000002f7a78818 error 30002 in rsyslogd[10000+88000]

This is with Debian unstable 32-bit userland as of 2015 summer. It did 
not happen with 4.12.

More bad news: all my sun4v machines crash on boot with DMA+IOMMU 
problem (will send a separate mail with details).

-- 
Meelis Roos (mroos@linux.ee)
