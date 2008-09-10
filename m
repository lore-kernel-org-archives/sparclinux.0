From: David Miller <davem@davemloft.net>
Date: Wed, 10 Sep 2008 20:31:37 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080910.133137.65935930.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 10 Sep 2008 17:34:20 +0300 (EEST)

> I'm trying to boot Linux on E3500 (1 system board with 2x400 MHz CPUs).
> 
> etch, lenny and some other daily debian netboot installers crap out with
> psycho_irq_build: Wacky INO [3c]

Can you email me the "prtconf -pv" output so that I can add it to the
prtconfs collection GIT tree and also try to fix this bug?

Current kernels will trigger this error as well.
