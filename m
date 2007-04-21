From: David Miller <davem@davemloft.net>
Date: Sat, 21 Apr 2007 22:33:26 +0000
Subject: Re: QuadEthernet driver broken
Message-Id: <20070421.153326.18304491.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87lkgxgxvj.fsf@chbouib.org>
In-Reply-To: <87lkgxgxvj.fsf@chbouib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Marcel van Nies" <morcles@gmail.com>
Date: Sat, 21 Apr 2007 20:43:14 +0200

> The MAC address assignment at module loading is simply forgotten.
> The bug at module unloading is caused by an incorrect call.
> 
> The bug at module unloading does not only happen for sunqe,
> sunlance and sunhme (sbus) suffer from it too.
> 
> This patch fixes the sunqe driver.
> The sunlance and sunhme will follow.
> 
> I've tested this on my SS20.
> Thanks.
> 
> Signed-off-by: Marcel van Nies <morcles@gmail.com>

If only you tested the patch itself as thoroughly :-)

Your email client adds newlines and other damage to your patches.

I'll fix them up this time but next time I will likely not be so kind
:-)

If in doubt, email the patch to yourself and try to apply it.  This
will save your time as well as mine.
