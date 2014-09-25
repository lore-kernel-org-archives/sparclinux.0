From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 25 Sep 2014 07:06:01 +0000
Subject: Re: [PATCH v2 02/22] PCI/MSI: Remove useless bus->msi assignment
Message-Id: <20140925070601.GF12423@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kbCYTQG2MZjuOjyn"
List-Id: <sparclinux.vger.kernel.org>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
	<1411614872-4009-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-3-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, arnab.basu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 11:14:12AM +0800, Yijing Wang wrote:
> Currently, PCI drivers will initialize bus->msi in
> pcibios_add_bus(). pcibios_add_bus() will be called
> in every pci bus initialization. So the bus->msi
> assignment in pci_alloc_child_bus() is useless.

I think this should be the other way around. The default should be to
inherit bus->msi from the parent. That way drivers don't typically have
to do it, yet they can still opt to override it if they need to.

For Tegra for example I think it would work if we assigned the MSI chip
to the root bus (in tegra_pcie_scan_bus()) and then have it propagated
to child busses in pci_alloc_child_bus() so that tegra_pcie_add_bus()
can be removed altogether.

Thierry

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI77YAAoJEN0jrNd/PrOhZ/IQAMCSt26z+T6Q8TozfHBY40d1
VjyfIqF++JMHsJp9JBnJk7W/SdKcW+ClXvgZjtR4hqvTRlYUBPk6Sn3JWpi3RslY
GHt/y1pNGzk05qLADjlA8CAGVjq0Vspw5WO5SLjzu10gfvcddAX7YKRcWz5vW9uv
TcG+NFcDyGRaNg+ATkJ8Ep4rVN3eIkh9te9CE/pG5zQAV+NEZkaN4v9hRFubWIPy
HUXyDu+8aTJ3YUyhrXkbGR23i0lLzcWsqhrcjbbbQj0swxngijMgBbzJU2jJ0rxx
5CjTbs0mgvqKfsX1WQ3Df61rSN/krlMiZeD66YuMTuWdlzZkGJqpHCDkKdx2rITZ
o2IXg6faK1OARr8JfubrXil2utfpJkvBJR2fWmH0j37ZkEb249skTCAnb2yroyhJ
Mz3BmS+nAgPJkQUTTVZigeR+90KASb/WQrFPZhvOPK/ioMy0UyGy6uvNYm4rLXK+
gWN2TjIaniEFM60xJLFPgsVuf9XXKUZ0REybeTiDM65mofLUSkxtMbK/mrcBdHgF
kdO+JJ93hN6vnnqpqA/QjKNJebZm0PUjSTZvXIlzBs/v+gOh4bWewATJLbcgll/g
w85vBMPaceGBcjBIBul927T7Uf+2pLOmJHmM+eCzXSdxAyQ8qx75Su9uWOY3sX3Q
JDxVrWb34Dj7sIqL36a3
=f2MC
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
