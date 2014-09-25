From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 25 Sep 2014 07:38:01 +0000
Subject: Re: [PATCH v2 17/22] s390/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <20140925073800.GM12423@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W4pDZ/VvazBYHhxQ"
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-18-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-18-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David


--W4pDZ/VvazBYHhxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:27AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
[...]
> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>  	}
>  }
> =20
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)

static?

--W4pDZ/VvazBYHhxQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8ZYAAoJEN0jrNd/PrOhT54QAIN9jc2i8zDFXQP0O2xLX151
K/0a6f2Ke1ts4th35u5jkXxtnjEubc8RMuU2k+Dft0pOk1wQqfi7CmdJtG+MrGqI
IZ78syU0TLzw2I2IhhCW/qIrc0eK9gcVpY5FnYxNGNsErYVOHB5w2lqj65UXkrK1
KuKTi4wk7SBfs7D0I7UVe9CjiGte3h4Wkm0FExDPekBjlb+NheufDExalF1vv5VW
Y/Ers3FW9kjTCLWHf+wS7Sg7a/uq8PfTG3hkn7ja7ykCouBoheB+pb1OmV5boizz
/H9TvN+P3WCd3TCe0pz5qI8icntR/5V09HiM3OM1sGqwWopvZgKiw8RSXwJMKdb3
4NsDxyu6glUOMpuFyDxzQ+iC94LeTq1L4C4oTfrdMdCQetJQm1DxWQYo4iPy1Luz
cyWf37Gr7RoNuPlx++ONPfub8xDPP6LpDm7Jf1ztIuHNRnN0D/EYNP/3W6s2en4w
0n4URoSBn7blmJQPOKQ+oNkw295vAc0bSU+NlqjdnpMhJq/Aq+olHB4Of97IKXtk
7lLqyJAX6ISNs302AVES9Wch7UW6MWrlpxiQk3HkGZBvFExbGCTD806d0wr9+V9Y
XcvfTABfe5ycOd28a4HwZx0BpglxbMRwarqwdwhpA9H0500K4lmTPrzZLVY+B0AB
UxhsWg3u+nU6NtiAWuwY
=lpw6
-----END PGP SIGNATURE-----

--W4pDZ/VvazBYHhxQ--
