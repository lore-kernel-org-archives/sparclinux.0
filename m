From: Meelis Roos <mroos@linux.ee>
Date: Thu, 15 Dec 2005 09:28:43 +0000
Subject: Re: 2.6.15.rc5+git fails to boot on Ultra 5
Message-Id: <Pine.SOC.4.61.0512151126550.26428@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Don't enable CONFIG_CC_OPTIMIZE_FOR_SIZE please.
> It builds unusable kernels on sparc64.

Hmm, I can't find it in my .config and it is not offered in menuconfig. 
It does exist in init/Kconfig and this file is included though. Strange.

> I'm pretty sure you turned that on because that trace
> is what you get with such a miscompiled kernel.

I turend it on for every machine when I was asked - because Linus told 
it's faster :-)

-- 
Meelis Roos (mroos@linux.ee)
