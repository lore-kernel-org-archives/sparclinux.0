From: David Miller <davem@davemloft.net>
Date: Mon, 25 Feb 2008 03:51:25 +0000
Subject: Re: sparc64 section mismatch status
Message-Id: <20080224.195125.22518862.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080222203910.GG7154@uranus.ravnborg.org>
In-Reply-To: <20080222203910.GG7154@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Feb 2008 21:39:10 +0100

> After applying the patches I just sent to you
> and a third for hpt366 (sent to Bart) my sparc64
> build is section mismatch clean.

Great.

> I have not tried different configs neither
> allyesconfig etc.

We can get to that later.

> If you see any section mismatch warnings in the
> configs you use then please do a
> 
> make CONFIG_DEBUG_SECTION_MISMATCH=y
> 
> build and send me the config + the warning output
> and I will see if I can fix it.
> 
> Or even better - fix it up yourself...

I've noticed this facility and I will try to take care
of any leftovers, thanks!
