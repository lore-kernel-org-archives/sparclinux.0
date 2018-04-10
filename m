From: Meelis Roos <mroos@linux.ee>
Date: Tue, 10 Apr 2018 18:45:09 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <alpine.LRH.2.21.1804102144240.32411@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee> <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

> commit bc270e0028cd0856d5689cab38f0071f0d07b3be
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Apr 10 08:47:34 2018 -0500
>=20
>     sparc/PCI: Request legacy VGA framebuffer only for VGA devices

Thank you.

It does not seem to compile for me:

  CC      arch/sparc/kernel/pci.o
arch/sparc/kernel/pci.c: In function =A1pci_claim_legacy_resources=A2:
arch/sparc/kernel/pci.c:644:26: error: =A1bus=A2 undeclared (first use in t=
his function)
  pcibios_bus_to_resource(bus, p, &region);


--=20
Meelis Roos (mroos@linux.ee)
