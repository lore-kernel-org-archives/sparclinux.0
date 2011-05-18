From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 May 2011 15:41:49 +0000
Subject: Re: [PATCH] of: fix race when matching drivers
Message-Id: <BANLkTimV0Xm7-C2yRh7bcyaQzdgET+0vmg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTikhKqcpdadpM3RQdYvDrPn46_v6_Q@mail.gmail.com>
 <20110517.134312.226762699.davem@davemloft.net> <alpine.SOC.1.00.1105021259220.6200@math.ut.ee>
 <1305732459_6563@mail4.comsite.net>
In-Reply-To: <1305732459_6563@mail4.comsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Milton Miller <miltonm@bga.com>
Cc: David Miller <davem@davemloft.net>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, May 18, 2011 at 9:27 AM, Milton Miller <miltonm@bga.com> wrote:
> If two drivers are probing devices at the same time, both will write
> their match table result to the dev->of_match cache at the same time.
>
> Only write the result if the device matches.
>
> In a thread titled "SBus devices sometimes detected, sometimes not",
> Meelis reported his SBus hme was not detected about 50% of the time.
> From the debug suggested by Grant it was obvious another driver matched
> some devices between the call to match the hme and the hme discovery
> failling.
>
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> ---
>
> Grant, I really think this of_match cache in the device node is bad a
> bad tradeoff, and am willing to submit patches to remove it for 2.6.40.
> It is only used by about 26 drivers and all use it once during probe
> to fill out their driver data. =A0It comes at the cost of a long for
> every struct device in every system.

Ah, bugger.  I had /thought/ that matching and probing were kept
together with a mutex.  So, yes, this is bad and the of_match needs to
be removed.  Thanks for volunteering to submit the patch.  It should
be backported to 2.6.39 too.

> I'll even offer to throw in a patch to cache the parsing of the
> compatible property to speed up of_device_is_compatible if needed.

That would be useful.  :-)

I'll pick up your patch right now and fire it off to Linus.

g.

>
>
>
> Index: work.git/include/linux/of_device.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- work.git.orig/include/linux/of_device.h =
=A0 =A0 2011-05-18 09:57:01.014386816 -0500
> +++ work.git/include/linux/of_device.h =A02011-05-18 09:58:27.537431575 -=
0500
> @@ -21,8 +21,15 @@ extern void of_device_make_bus_id(struct
> =A0static inline int of_driver_match_device(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 const struct device_driver *drv)
> =A0{
> - =A0 =A0 =A0 dev->of_match =3D of_match_device(drv->of_match_table, dev);
> - =A0 =A0 =A0 return dev->of_match !=3D NULL;
> + =A0 =A0 =A0 const struct of_device_id *match;
> +
> + =A0 =A0 =A0 match =3D of_match_device(drv->of_match_table, dev);
> + =A0 =A0 =A0 if (match) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->of_match =3D of_match_device(drv->of_m=
atch_table, dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0extern struct platform_device *of_dev_get(struct platform_device *dev);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
