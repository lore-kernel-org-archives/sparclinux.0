From: Meelis Roos <mroos@linux.ee>
Date: Wed, 06 Jan 2016 15:21:24 +0000
Subject: Recent spontaneous reboots on multiple machines
Message-Id: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Recently (maybe since 4.3.0 or for some models, during 4.4-rc cycle 
before rc5), multiple sparc64 machines have been spontaneously rebooting 
for me during kernel compiles.

First noticed on V240 and E450 (4.3 timeframe).
Recently also on V440, V100, T2000.

Nothing in LOM console history for dmesg, just spontaneous reboot.

All machines have different kernel configs, machine-optimized plus 
random set of debug options and other features.

I am planning to try bisecting this but it will take time. Any other 
good advice for speeding up the pinpointing?

-- 
Meelis Roos (mroos@linux.ee)
