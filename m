From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 19 Aug 2012 15:41:42 +0000
Subject: Re: [PATCH] silo: Don't touch %tick_cmpr on sun4v cpus.
Message-Id: <20120819154142.GA14751@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120815.011416.353619816610212386.davem@davemloft.net>
In-Reply-To: <20120815.011416.353619816610212386.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 15, 2012 at 01:14:16AM -0700, David Miller wrote:
> 
> This generates an illegal instruction exception.
> 
> This has a long history.  For the first sun4v port of SILO in commit
> 494770a17eea7192d3242051e76f4da6d838e3a1 ("SILO Niagara/SUN4V
> support") this code was removed entirely.
> 
> But later this was found to regress older UltraSPARC boxes, so we put
> it back in commit bd708e35bdcd8e92cb7c65368f2a356982df7cd8 ("Fix
> Ultra10 SILO timer").  But that was wrong too.
> 
> The OBP still owns the trap table when SILO runs and it uses the
> %tick_cmpr generated interrupt.  This has a bad interraction with how
> we use the %tick register in SILO.
> 
> SILO first reads the %tick register and remembers this value as the
> time base.
> 
> Later, we read %tick again, compute the difference, and use this to
> calcualte the amount of time elapsed.
> 
> OBP's %tick_cmpr interrupt handler is doing something funky, such as
> resetting %tick, which makes our timeouts never actually expire.
> 
> This issue doesn't exist on sun4v machines, and we absolutely cannot
> try to touch the %tick_cmpr register as that generates an illegal
> instruction trap on such cpus.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> I just committed this into the SILO git repo.
> 
> Debian folks, you really want this propagated into your installer as
> soon as possible.  All the install ISOs will crash in SILO on all
> sun4v (Niagara) machines unless an explicit SILO boot target is given
> on the boot command line.  I used "boot cdrom install" to get around
> this.
> 
> It triggers any time the timer mechanism is enabled ("timeout=foo" is
> specified in silo.conf)

Thanks, David.

I just uploaded a new silo package (1.4.14+git20120819-1) including 
these fixes to unstable, and would encourage everyone to test it (it 
should appear on the mirrors within a few hours). After a grace period 
of 10 days we are going to arrange for its propagation to testing, 
given that no problems are reported.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
