From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 10 Mar 2006 09:23:33 +0000
Subject: Re: [PATCH] sparc64: fix sparc_floppy_irq's auxio_register reseting
Message-Id: <20060310.012333.52015340.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Bernhard R. Link" <brlink@debian.org>
Date: Sat, 21 Jan 2006 18:49:40 +0100

> The patch "[SPARC64]: Get rid of fast IRQ feature"
> moved the the code from arch/sparc64/kernel/entry.S:
>       lduba           [%g7] ASI_PHYS_BYPASS_EC_E, %g5
>       or              %g5, AUXIO_AUX1_FTCNT, %g5
>       stba            %g5, [%g7] ASI_PHYS_BYPASS_EC_E
>       andn            %g5, AUXIO_AUX1_FTCNT, %g5
>       stba            %g5, [%g7] ASI_PHYS_BYPASS_EC_E
> to arch/sparc64/kernel/irq.c:
>               val = readb(auxio_register);
>               val |= AUXIO_AUX1_FTCNT;
>               writeb(val, auxio_register); 
>               val &= AUXIO_AUX1_FTCNT;
>               writeb(val, auxio_register);
> This looks like it it missing a bitwise not, which is reintroduced 
> by this patch.
> 
> Due to lack of a floppy device, I could not test it, but it looks
> evident.
> 
> Signed-off-by: Bernhard R Link <brlink@debian.org>

Patch applied, thanks Bernhard.
