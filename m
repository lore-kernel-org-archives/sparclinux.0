From: Meelis Roos <mroos@linux.ee>
Date: Thu, 05 May 2016 14:59:35 +0000
Subject: Re: Netra T1-105 reboot hang (prtfconf/openprom module related?)
Message-Id: <alpine.LRH.2.20.1605051758110.4685@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I have a Netra T1-105 (OBP is latest that was released, 3.10.27 ME) with 
> Linux (debian unstable snapshot from July 2015) running latest devel 
> kernels and I have not seen it rebooting without hang yet (4.1, 4.2, 
> 4.3-rc5 tested so far).
[...]
> Probably related: running prtfconf puts the system into a soft lockup - 
> answers to ping but no ssh any more. openprom module is built into the 
> kernel. On hang, I get the same kind of backtrace from watchdog but from 
> different offset in misc_open:

I retested it with 4.6-rc6-... and it has been fine with two lastest 
post-4.5 kernels (both reboot and prtconf -pv). So something has fixed 
it.

-- 
Meelis Roos (mroos@linux.ee)
