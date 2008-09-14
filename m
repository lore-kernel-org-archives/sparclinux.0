From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 21:38:27 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809150037150.19219@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Something is wrong with some debugging feature.
> 
> Please turn off CONFIG_STACK_DEBUG and let's see if that makes
> the problem go away.

Turned of that and two more debugging options (sysrq check and something 
else) and it started booting up to the same oops that I already 
reported.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
