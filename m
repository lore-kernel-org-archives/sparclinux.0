From: Meelis Roos <mroos@linux.ee>
Date: Thu, 18 Aug 2005 11:50:31 +0000
Subject: current_thread_info_reg undefined
Message-Id: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Todays 2.6.13-rc6+git tree has broken many modules with warning like 
this on sparc64:
*** Warning: "current_thread_info_reg" [drivers/net/ppp_deflate.ko] undefined!

These warnings don't go away after make clean.

-- 
Meelis Roos (mroos@linux.ee)
