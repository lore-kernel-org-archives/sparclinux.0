From: Meelis Roos <mroos@linux.ee>
Date: Wed, 25 Sep 2013 23:36:59 +0000
Subject: SILO always tells it loaded kernel version 3.6.0
Message-Id: <alpine.SOC.1.00.1309260234380.22367@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just a curious thing I noticed: in the past, SILO told what version of 
kernel it loaded. Nowadays with newer kernels, it always tells
Loaded kernel version 3.6.0
asi it would be stuck in 3.6.0. Is it something silo does strangely or 
do we put bad magic number into kernel image nowadays?

-- 
Meelis Roos (mroos@linux.ee)
