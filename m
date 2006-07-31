From: Marc Zyngier <maz@misterjones.org>
Date: Mon, 31 Jul 2006 15:53:21 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <wrpwt9tahzi.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "Meelis" = Meelis Roos <mroos@linux.ee> writes:

Meelis> Just tried 2.6.18-rc3 on my Ultra 5 using serial console. It
Meelis> hangs after telling ttyS0 is the console. No response to break
Meelis> either, and booting with -p does not give anythig more.

This is odd. 2.6.18-rc3 works fine here on E250 and Ultra-5, both with
serial console...

Compiler problem? I see you're using a recent 4.1... Here's my
/proc/version:

Linux version 2.6.18-rc3 (maz@because) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #3 Mon Jul 31 17:02:01 CEST 2006

	M.
-- 
And if you don't know where you're going, any road will take you there...
