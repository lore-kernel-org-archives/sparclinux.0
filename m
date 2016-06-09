From: Meelis Roos <mroos@linux.ee>
Date: Thu, 09 Jun 2016 09:27:01 +0000
Subject: Re: tulip hangs under load on sparc64
Message-Id: <alpine.LRH.2.20.1603302336240.30330@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The problem is still present in recent kernels, I have seen it on Netra 
X1 and Fire V100 that have onboard davicom. This time the problem 
results in problems during git pull - git pull is slow and often breaks 
with invalid data. Nothing in dmesg.

I retried 4.5 with other ways - ncftp downloading a big .iso to X1. 
Speed is limited to about 2.3 MB/s, at first it was stable, then it 
hanged.

Further tests show it usually in 20-30 kB/s speed range and then breaks 
with corruption.

So the issue is still present.

-- 
Meelis Roos (mroos@linux.ee)
