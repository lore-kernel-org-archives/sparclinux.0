From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 21:56:31 +0000
Subject: Re: [RFC PATCH] sparc32,leon: always include leon code in build
Message-Id: <20120514.175631.2151466253201984741.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120514202951.GA4439@merkur.ravnborg.org>
In-Reply-To: <20120514202951.GA4439@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 22:29:51 +0200

>>From c1caf78ed4ce33bc15ba5e1f186938a1c6668049 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 14 May 2012 22:22:26 +0200
> Subject: [PATCH] sparc32,leon: always include leon code in build
> 
> Numerous times I have hit situations where my changes failed
> to build on LEON.
> Update so we always include leon code in the build.
> 
> The resulting kernel will NOT boot on leon, but in this way we
> avoid introducing regressions in leon specific parts of the code.
> 
> As leon and sun4x uses different values for ASI_M_MMUREGS
> I do not expect the same kernel to actually boot both
> on leon and sun boxes.
> At least I see no way around this right now.
> 
> All other differences looks manageable if we can find a way around
> the ASI_M_MMUREGS issue.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Indeed, it's a pain.  My basic build tests involve 4 cases
because of this (iterating on CONFIG_SMP and CONFIG_LEON).

But I think we should resolve the remaining issues that keep LEON
builds from working on other cpus first, because the thing you're
after will fall transparently out of that.

It's beyond embarassing that with how much we parameterize things at
runtime on sparc32, we can't do something so simple as adding LEON to
the mix transparently.

I think we should have been more strict when reviewing the original
LEON patches.

For one thing there is no reason in the world to have a different
value of ASI_M_MMUREGS.

If LEON puts that stuff at a different ASI, well then the code needs
to be different on LEON and either patched at run-time or hooked into
the various OPS method vectors we have.
