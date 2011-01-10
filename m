From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jan 2011 22:07:39 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110110.140739.22048183.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 10 Jan 2011 23:03:46 +0100

> I have tried 1) and 2)
> Independent and together.
> 
> The result was the same in all cases.
> 
> I have also tried with a LG Flatron W2425T Monotor - the same result.

Thanks for doing this.

> On this box I have never had any graphical application running - so
> we should also consider that this is a HW bug on my video card.

Maybe, maybe not :-)

I'm doubtful because the PROM's programming of the PLL works fine, as
soon as the driver tries to override the settings is when we see
problems.
