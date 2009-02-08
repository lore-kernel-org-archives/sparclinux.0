From: Eric Brower <ebrower@gmail.com>
Date: Sun, 08 Feb 2009 00:15:44 +0000
Subject: Re: SBus HME startup failure
Message-Id: <ec7cefb0902071615g2df92947ka22a17a3c3980016@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901271205350.17434@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 6, 2009 at 11:46 PM, David Miller <davem@davemloft.net> wrote:
>
> Meelis and Eric, does the following patch do the trick?
>
> --------------------
> sunhme: Don't match PCI devices in SBUS probe.
>
> Unfortunately, the OF device tree nodes for SBUS and PCI
> hme devices have the same device node name on some systems.
>
> So if the name of the parent node isn't 'sbus', skip it.
>
> Based upon an excellent report and detective work by
> Meelis Roos and Eric Brower.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
>
> diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
> index 7a72a31..cc4013b 100644
> --- a/drivers/net/sunhme.c
> +++ b/drivers/net/sunhme.c
> @@ -2629,6 +2629,14 @@ static int __devinit happy_meal_sbus_probe_one(struct of_device *op, int is_qfe)
>        int i, qfe_slot = -1;
>        int err = -ENODEV;
>
> +       sbus_dp = to_of_device(op->dev.parent)->node;
> +       if (is_qfe)
> +               sbus_dp = to_of_device(op->dev.parent->parent)->node;
> +
> +       /* We can match PCI devices too, do not accept those here. */
> +       if (strcmp(sbus_dp->name, "sbus"))
> +               return err;
> +
>        if (is_qfe) {
>                qp = quattro_sbus_find(op);
>                if (qp = NULL)
> @@ -2734,10 +2742,6 @@ static int __devinit happy_meal_sbus_probe_one(struct of_device *op, int is_qfe)
>        if (qp != NULL)
>                hp->happy_flags |= HFLAG_QUATTRO;
>
> -       sbus_dp = to_of_device(op->dev.parent)->node;
> -       if (is_qfe)
> -               sbus_dp = to_of_device(op->dev.parent->parent)->node;
> -
>        /* Get the supported DVMA burst sizes from our Happy SBUS. */
>        hp->happy_bursts = of_getintprop_default(sbus_dp,
>                                                 "burst-sizes", 0x00);
>

This works for me as well-- thanks.

I wasn't confident enough that the direct parent of a non-QFE HME
would always be an "sbus" node, though it certainly seems like a valid
assumption.

-- 
E
