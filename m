From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Apr 2015 18:59:07 +0000
Subject: IOMMU patch seems to work fine on older sparcs
Message-Id: <alpine.LRH.2.11.1504192155340.11284@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tried todays git (4.0.0-08110-g64fb1d0 on most, the first round on 
some) on my currently active sparc64 testbed. Seems to work fine so far 
(debian upgrade + local git clone in loop), no visible regressions 
comapred to 4.0. The machines include:

Ultra 1
Ultra 2 (US II CPU)
Ultra 5
V100
Netra X1
Blade 100
V440
T2000

More test machines will follow but the first round is fine. Good work!

-- 
Meelis Roos (mroos@linux.ee)
