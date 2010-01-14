From: Marc Zyngier <maz@misterjones.org>
Date: Thu, 14 Jan 2010 17:30:54 +0000
Subject: Re: [PATCH] sparc: leds_resource.end assigned to itself in
Message-Id: <20100114183054.0b53c351@taxman.wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4B4F4C9B.9040202@gmail.com>
In-Reply-To: <4B4F4C9B.9040202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roel Kluin <roel.kluin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 14 Jan 2010 17:55:55 +0100
Roel Kluin <roel.kluin@gmail.com> wrote:

> These statements appear redundant.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is there any reason to assign this to itself?
> 
> diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
> index f3b5466..773caf4 100644
> --- a/arch/sparc/kernel/central.c
> +++ b/arch/sparc/kernel/central.c
> @@ -99,7 +99,6 @@ static int __devinit clock_board_probe(struct
> of_device *op, 
>  	p->leds_resource.start = (unsigned long)
>  		(p->clock_regs + CLOCK_CTRL);
> -	p->leds_resource.end = p->leds_resource.end;

I have the feeling that the right fix is to have:

	p->leds_resource.end = p->leds_resource.start;

hence describing a 1 byte region.

	M.
-- 
I'm the slime oozin' out from your TV set...
