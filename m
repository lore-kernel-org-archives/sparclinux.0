From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 25 Sep 2014 07:36:09 +0000
Subject: Re: [PATCH v2 14/22] MIPS/Xlp/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <20140925073608.GK12423@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6K2R/cS9K4qvcBNq"
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-15-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-15-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David


--6K2R/cS9K4qvcBNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:24AM +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Nit: s/irq/IRQ/ in the above.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  arch/mips/pci/msi-xlp.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
> index e469dc7..6b791ef 100644
> --- a/arch/mips/pci/msi-xlp.c
> +++ b/arch/mips/pci/msi-xlp.c
> @@ -245,7 +245,7 @@ static struct irq_chip xlp_msix_chip =3D {
>  	.irq_unmask	=3D unmask_msi_irq,
>  };
> =20
> -void arch_teardown_msi_irq(unsigned int irq)
> +void xlp_teardown_msi_irq(unsigned int irq)

Should this not be static now as well?

Thierry

--6K2R/cS9K4qvcBNq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8XoAAoJEN0jrNd/PrOhrs4P/Rg10uO2/sCyBwOPDpHaskVO
8blYsnipag0xv7pyGtAeiEVLgpzcQpv+zjXPmti+R1qI1OVkUXblvYhNtz/CDMvg
AN6CaoZI3llRg3fZwiayj3m/i1HpiXTPqYPK3sWanCUMmZJe73eUj8zMt6bH7yPG
WsuUwWTrc2hcscIDucigcNopQ0fuh0vLYLWgiZe+qJdJIrvGkvGN4h0pHuqIkk0o
DUyMUme8HOL1irxSWYnnmkTPx3TOAWDn7VJVxJgpIKEG0A/X1GCi/4wCkMMxtuxH
1V0aRu/k9AsOR5BVDROfyZCHvuTVLZeXP54ehWxAyA1GwS55Z36FNsl/JLtZ2WhO
95CX6ac9NMDLgmGr9W19SAffXn47Yy/1fvK5zq0F+taK005ajIxufmnoSVrzZsH8
dS8MoFslKB8B2EKW5874CFVUKGx5hZTARp12WWvTfJehLTYfJNpSpdjRdI7LBggj
/PNzvpDkiwwSVzXcJUU45wOZvaS0ImoH3Xn2GF91D/kO+jfFc52lI8Tv8Ixw7Hgl
pJObojrzrQJe20K2NJP9xuCNXUXiI0/EbfwZf/MxE5u/FSxigS8vajMY8CFMlQ5N
4sSi2qWsKa2ZrGMo5dyDfblWSjy1U1O752LQXn+8ddng18wDV/tk/tzZU0Xsywy6
jGgaMyNaRi22AESZhUqv
=xvjk
-----END PGP SIGNATURE-----

--6K2R/cS9K4qvcBNq--
