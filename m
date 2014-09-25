From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 25 Sep 2014 07:37:01 +0000
Subject: Re: [PATCH v2 15/22] MIPS/Xlr/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Message-Id: <20140925073700.GL12423@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nrM5Z5VIJgwP9LWp"
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-16-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-16-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David


--nrM5Z5VIJgwP9LWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:25AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
[...]
> @@ -214,11 +214,11 @@ static int get_irq_vector(const struct pci_dev *dev)
>  }
> =20
>  #ifdef CONFIG_PCI_MSI
> -void arch_teardown_msi_irq(unsigned int irq)
> +void xlr_teardown_msi_irq(unsigned int irq)
>  {
>  }
> =20
> -int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +int xlr_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)

Can both of these now be static?

Thierry

--nrM5Z5VIJgwP9LWp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8YcAAoJEN0jrNd/PrOhmbYP/ikLBs/f/C3q0Ah+1wm0yIQ9
biLioTIcSkRAsIfmKvheDIwFqrlfVwxThhAFT1+1x9N/KgeZ0hTm7/ZzogCQEn9J
J90nv0Y1KRdY/exT1wfgVEFtITGMGqDKTScawCJSoqc/4iswAtYkap3QdftgmyDU
acFImPmiT5rTaF3oQXhgNTgRcMMsdGOYJg/64K0snGcBGCNDYr4ZutMiEzof/G7O
w5KUk61xP+tvpYWRebsG/ivvFVWXNwVnpAOPAq+j6ziVxLlFLvY/r7QZ0Z95kSTj
AqufUg6h2cePrzW3VGxKJ5HL0eLS43pMofUkRFqcNv/BEeE8ZEg5wd2mNCtAroXb
fG5+KClUrEYZ28WO5d7Bagvekb00O2SYJ6HQW9WoASguiLfMMGa0g9w8SxmES0Gv
axepd0VObagoL/0lUjvSs73S39kzWsShRysZ9hCEsox1Xt3kinX3wwIP+k97dsKC
LAyXKNzxzU5xtlsZONRwRx2SsBRnUApH6CgDE5SOBgSAM+Juuk/e4NES7iTHW1iA
7DrbU7XWcMc/SLbIanZv3gig1WuNUR011kUZ9cerQpTMZ5JX+pR/f59jbtgexuEt
2lqvEs5pj2RZfiZy+pl21B1hMz7UPuQm8Hw0NMsXQP9wPcDwLzYAqT7uhHdaBhLV
4rVgrCyYNcw+4+MK/Nhv
=crca
-----END PGP SIGNATURE-----

--nrM5Z5VIJgwP9LWp--
