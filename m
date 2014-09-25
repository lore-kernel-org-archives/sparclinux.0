From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 25 Sep 2014 07:34:36 +0000
Subject: Re: [PATCH v2 12/22] MIPS/Octeon/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <20140925073435.GJ12423@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rwgQ89ZNnFUwFHTC"
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-13-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-13-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David


--rwgQ89ZNnFUwFHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:22AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
[...]
> @@ -132,12 +132,12 @@ msi_irq_allocated:
>  	/* Make sure the search for available interrupts didn't fail */
>  	if (irq >=3D 64) {
>  		if (request_private_bits) {
> -			pr_err("arch_setup_msi_irq: Unable to find %d free interrupts, trying=
 just one",
> +			pr_err("octeon_setup_msi_irq: Unable to find %d free interrupts, tryi=
ng just one",
>  			       1 << request_private_bits);

Perhaps while at it make this (and other similar changes in this patch):

	pr_err("%s(): Unable to ...", __func__, ...);

So that it becomes more resilient against this kind of rename?

>  			request_private_bits =3D 0;
>  			goto try_only_one;
>  		} else
> -			panic("arch_setup_msi_irq: Unable to find a free MSI interrupt");
> +			panic("octeon_setup_msi_irq: Unable to find a free MSI interrupt");

> @@ -210,14 +210,13 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nv=
ec, int type)
> =20
>  	return 0;
>  }
> -

This...

> @@ -240,7 +239,7 @@ void arch_teardown_msi_irq(unsigned int irq)
>  	 */
>  	number_irqs =3D 0;
>  	while ((irq0 + number_irqs < 64) &&
> -	       (msi_multiple_irq_bitmask[index]
> +		(msi_multiple_irq_bitmask[index]

=2E.. and this seem like unrelated whitespace changes.

>  		& (1ull << (irq0 + number_irqs))))
>  		number_irqs++;
>  	number_irqs++;
> @@ -249,8 +248,8 @@ void arch_teardown_msi_irq(unsigned int irq)
>  	/* Shift the mask to the correct bit location */
>  	bitmask <<=3D irq0;
>  	if ((msi_free_irq_bitmask[index] & bitmask) !=3D bitmask)
> -		panic("arch_teardown_msi_irq: Attempted to teardown MSI "
> -		      "interrupt (%d) not in use", irq);
> +		panic("octeon_teardown_msi_irq: Attempted to teardown MSI "
> +			"interrupt (%d) not in use", irq);

And the second line here also needlessly changes the indentation.

Thierry

--rwgQ89ZNnFUwFHTC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8WLAAoJEN0jrNd/PrOhp2MQAK6S7hsneW6O97w/t1chjlGR
ug1JLAxeP84A0Vj4I6KwfrHjux8rDqoByI5bDhH+ywcRQuf90Dx9+L9QEfWlzkcC
K1qT+twZDUqVFhCIJtuEtNVJbEXb0NlPK74W/6cUubFdAKbY1+MZe66Z0BZlBl36
bjxEyTh6uZkemh8PLwP45mJQCTD/d5/lNGDCrgzKgurE1HIHXV1r0FoD9zLJZpfA
UATpp5rQYfePlynE1mCT+G0QXcfo+zf8kp49jLxeciX5QZYs8DbZ2IwbhG4ov2je
p8SHV5T+c8D1+Q7UjNbXpDGHz12Ctpby/bLd3+FGsmeIZJbE4o5NcE5pChZfI52v
Rgl0wLOlswsM2xoSGdhA1x51QEHqFxShBf/+FwbxLA7shNWELd6gRpv9mcYSv6oy
MgALA5tV5r18NZyBm+SsvwUrgAF7e1ndIU/UYhAH1lIz3CMtqTnZ2AZIpXoJeKLo
rtzWB2MThJnnZXUpW3Umj3UWoZkcAy6zQSWBGV40hC+t3dkr1US9bOgGIrO6huyy
qTqNG+A20dRO85W7LoslDg5CO401jS8JRiHbYQW9g+QhHkWLpROgcrCoK1dz+Q2B
QjaLp2fjuM7wyyYXRLcQo68i7Y9AUv2R+k1fidvlfuWXfvzbeK6x0BHSx8nhBec6
SU2aBh+SOaTeNEFZjRFv
=dRXg
-----END PGP SIGNATURE-----

--rwgQ89ZNnFUwFHTC--
