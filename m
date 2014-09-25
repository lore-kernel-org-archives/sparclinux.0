From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 25 Sep 2014 07:15:38 +0000
Subject: Re: [PATCH v2 01/22] PCI/MSI: Clean up struct msi_chip argument
Message-Id: <20140925071536.GG12423@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EDJsL2R9iCFAt7IV"
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-2-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:11AM +0800, Yijing Wang wrote:
> Msi_chip functions setup_irq/teardown_irq rarely use msi_chip
> argument.

That's not true. Out of the four drivers that you modify two use the
parameter. And the two that don't probably should be using it too.

50% is not "rarely". =3D)

>           We can look up msi_chip pointer by the device pointer
> or irq number, so clean up msi_chip argument.

I don't like this particular change. The idea was to keep the API object
oriented so that drivers wouldn't have to know where to get the MSI chip
=66rom. It also makes it more resilient against code reorganizations since
the core code is the only place that needs to know where to get the chip
=66rom.

Thierry

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI8EYAAoJEN0jrNd/PrOhKe8P+wRzEsusQS8lMmL8zyqvg5wy
x0Q4+eSI5aEkUEQz6Mtcld6eIwACphFOHeoDrAFauuxrjVqWslHdYAIAKbYoxG0e
xV9PJoc5PY24v4vnR5BvWEHxBfzfJ8QmFlDZGRvy3lqTPhTBOzLIbNUMO1gaoH1Q
MIzSjgl631075wZns41KNNx1TjCaXNeDwjkAyyX4bjJ7SL6ymrsxGo/zhCRCpZSk
2ks9AFoqFQoIOFeziuAW7WAx8BM9ah1ba5tc3oVZ6LC3JHrvoHZ5KCjITV75Geqb
dFzQh7Rx0yFdXVmNOX+O6XtFVvb7hNFELV1SAzQQXWl0Hyid6Dp0ZShKLSumNdG8
WvJFtUil25Prid9JVvpq+PrRGlbOucv0U+wi2cbdrE9/7UwtYoxAHNj/aTXdWwIv
d6ble8v0UT7l5Sk8QIFMI3VbatPqL/i+Mz8NijIKaMRug9/XmXZIN0Q05JhlbJ2b
/AWyYKLGAwYMrZcDU2v8CajO/NGUQ9D+mkqcN0NDsxmvP5woL6GC2tQzZABaAipF
LlbM5T6PfjxRfOvYNAIOJnttoirlQ4UI8CjVEeotPrchQalN7ZESvaHK0z2/Wrv1
kSvUiqTvOPtRaQn4rIs5MTi7tw5NBsG2MyWfy90WkITpn5vEYrX4JQITTUpa/x9B
IKT68Y/8ZFK3ksbjHtIe
=LSxe
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
