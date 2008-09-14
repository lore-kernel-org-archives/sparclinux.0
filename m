From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 18:32:55 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080914.113255.121158018.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Sun, 14 Sep 2008 18:43:38 +0300 (EEST)

> (gdb) x/10i 0x5813c0
> 0x5813c0 <mcount>:      ldub  [ %g6 + 0xc ], %g1
> 0x5813c4 <mcount+4>:    srl  %g1, 1, %g3
> 0x5813c8 <mcount+8>:    inc  %g3

Something is wrong with some debugging feature.

Please turn off CONFIG_STACK_DEBUG and let's see if that makes
the problem go away.
