From: David Miller <davem@davemloft.net>
Date: Sat, 22 Oct 2011 09:05:05 +0000
Subject: Re: longjmp question
Message-Id: <20111022.050505.269710721242970330.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 22 Oct 2011 10:00:24 +0100

> Is something conceptually wrong with just doing this:
> 
> asm volatile ("save; flush; restore");
> 
> It fixes the problem for freebsd (will test on linux later today), and 
> does not rely on compiler doing (or not doing) the "right" 
> optimization.

I would not do a "naked" save here, please just use the construct
I showed you with the %o7 register clobber.

If you don't allocate space for the new register window, you will
be writing the local registers to the parent's register window.

Maybe you get lucky and this works, but after spending multiple weeks
on this bug why take any chances at all at this point?
