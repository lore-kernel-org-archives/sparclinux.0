From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Nov 2016 09:35:14 +0000
Subject: 4.9.0-rc6-00086-g3b404a5 seems good on my sparc64 machines
Message-Id: <alpine.LRH.2.20.1611231248340.6788@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tried yesterdays git 4.9.0-rc6-00086-g3b404a5 on most of my sparc64 
machines and found no new regressions. The tests were only simple bootup 
tests so far (no dist-upgrade since my userspace is stuck in debian 
unstable 2015).

U1 U2 x1 t1-105 t1-200 v100 v120 e250 e220r e420r v210 v240 
v440 v245 t1000 t2000 t5120

-- 
Meelis Roos (mroos@linux.ee)
