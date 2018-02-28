From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 28 Feb 2018 23:08:29 +0000
Subject: Re: [PATCH] sparc: Use generic pci_mmap_resource_range()
Message-Id: <20180228230828.GR127842@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1519045452-22645-1-git-send-email-dwmw@amazon.co.uk>
 <20180219.094951.2098243214524004486.davem@davemloft.net>
 <1519053858.7876.84.camel@infradead.org>
 <20180219.103025.1676484157305869188.davem@davemloft.net>
In-Reply-To: <20180219.103025.1676484157305869188.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: dwmw2@infradead.org, sparclinux@vger.kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On Mon, Feb 19, 2018 at 10:30:25AM -0500, David Miller wrote:
> From: David Woodhouse <dwmw2@infradead.org>
> Date: Mon, 19 Feb 2018 15:24:18 +0000
>=20
> >> For one, the sparc specific code allows mmap'ing any address range
> >> within a PCI bus device.=A0=A0The generic code does not allow that.
> >=20
> >=20
> > You mean any address range in a given PCI bus even if there is no
> > actual device with a BAR at the corresponding address?
> >=20
> > Would I be right to assume this was only available through the legacy
> > procfs API? I think it should be possible to accommodate it, and it
> > does look like I'd missed this requirement the first time round; thanks
> > for pointing it out.
>=20
> It was probably the case that only procfs could do it.
>=20
> It is the mechanism by which we were able to let the X server poke
> around in VGA ISA space.  It does a bus I/O space map for the bus
> device above the VGA card.

What's the bottom line?  Do we want this for sparc?  If so, do you
want to take it, Dave M, or would you like me to?
