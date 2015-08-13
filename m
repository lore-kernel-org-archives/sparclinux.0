From: Meelis Roos <mroos@linux.ee>
Date: Thu, 13 Aug 2015 10:15:49 +0000
Subject: Re: bisected: boot hang on sparc64 after PCIe changes
Message-Id: <alpine.LRH.2.20.1508131315280.7229@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1508122118210.18637@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1508122118210.18637@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 4.1.0 worked but 4.2-rc2 hangs on boot after switching console but 
> before reprinting dmesg to the new console. That happens on 2 of my 
> sparc64's: T2000 and V245. These happen to have the PCIe slot names in 
> sysfs so it may be related. The following commit breaks the boot at 
> least on V245 where I performed the bisection:

Just verified that T2000 is also hanging because of the same commit.

-- 
Meelis Roos (mroos@linux.ee)
