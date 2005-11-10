From: Meelis Roos <mroos@linux.ee>
Date: Thu, 10 Nov 2005 13:09:29 +0000
Subject: unknown symbol uts_sem in solaris.ko
Message-Id: <Pine.SOC.4.61.0511101508030.19615@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Todays git release gives this:

WARNING: /lib/modules/2.6.14-g3b44f137/kernel/arch/sparc64/solaris/solaris.ko needs unknown symbol uts_sem

Maybe a result of recent changes to stop extra rebuilds when 
only localversion changes - so only utsname is affected.

-- 
Meelis Roos (mroos@linux.ee)
