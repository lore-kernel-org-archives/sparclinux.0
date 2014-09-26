From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 26 Sep 2014 08:09:49 +0000
Subject: Re: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
Message-Id: <20140926080949.GF31106@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5CUMAwwhRxlRszMD"
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-4-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> use irq chip_data to save the msi_chip pointer. They
> already call irq_set_chip_data() in their own MSI irq map
> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> is useless.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 51d7e62..50f67a3 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -41,14 +41,13 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, st=
ruct msi_desc *desc)
>  	if (err < 0)
>  		return err;
> =20
> -	irq_set_chip_data(desc->irq, chip);
> -
>  	return 0;
>  }
> =20
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> -	struct msi_chip *chip =3D irq_get_chip_data(irq);
> +	struct msi_desc *entry =3D irq_get_msi_desc(irq);
> +	struct msi_chip *chip =3D entry->dev->bus->msi;
> =20
>  	if (!chip || !chip->teardown_irq)
>  		return;
> --=20
> 1.7.1
>=20

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJR9NAAoJEN0jrNd/PrOh5cAP/2aYAkwGt796/z3rQsXfEXhG
hPI6dXwueP4Re7P03WrSfn6JEowEsDYFLqLJJYQLwlDQa96WTd85jidBUhQRniqy
GPHoUY+c4qiQjJak+b2y4jMMNqJnWoLw57Wd1Nmy2g2pocWKwiKA1VEem2ZZPaxR
QxhYqhwK8IxOu092oPpVV8m2GtFSUzbuOoE0a3muYP+gExweDN6v485fm+PKfIVU
rmCMnmkkT9oUVNYUlQDSf0xXb+t0PNJDbGZHPM3rKQFQA45Xhadzs2D/nk1CSwoj
7EO8sq/qkfHnyXvxpvazxq2V1xsGkG63RTRmhIzP2VGDj/AI6G9AlM5dFOzPctSf
8v8FNLESIHmHKyp9IKT1pCWg6jbRHFlhL9be5+uudiDYgvXiGjtco4Jta1hlgHNk
Qd7zRsH6Y+ocewQ2sqDMrwkOEzetOfnGmjjtb3q6VaeahtwPdRKWhQcjfO//zIW3
83yoON4lx7AS1aDMRywNXbk8A6ja8ndVS2amfm6TJCbIVy6A78AnCRx4n/ShluFl
WD1TekKOyh2u2JtRagRSb0xxFwwsqzlYrOElj00zxCZJAKihIzjMf4ogfxnj2OOn
ZEF1WTMpjTpy+QB7r22R0qFX9yVBBCgRM8heGbQXeVMPD/AvmVhx803Ry2r6SmcU
iefPiqiqqocKKcpN4rMB
=jw7p
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
