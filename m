From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 23:27:30 +0000
Subject: Re: [PATCH v3 29/34] sparc/PCI: get rid of device resource fixups
Message-Id: <CAErSpo5Z10UrstkGLhCrEQm_vrMA0a7TNk=D256FixrG_V6n6w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com> <20120307223432.25669.51388.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307223432.25669.51388.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Wed, Mar 7, 2012 at 3:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Tell the PCI core about host bridge address translation so it can take
> care of bus-to-resource conversion for us.
>
> Previously, when enumerating PCI devices from the OF device tree, sparc
> used pci_resource_adjust() to perform this address fixup for P2P bridge
> windows in the following places:
>
> =A0 =A0pci_cfg_fake_ranges()
> =A0 =A0apb_fake_ranges()
> =A0 =A0of_scan_pci_bridge()
>
> This patch replaces pci_resource_adjust() with the generic
> pcibios_bus_to_resource() and the appropriate pci_add_resource_offset()
> use to tell the PCI core about host bridge apertures and offsets.
>
> Resources of non-P2P bridge devices are set in pci_parse_of_addrs() and,
> as far as I can see, never converted to CPU addresses.

I'm concerned about this -- the fact that we seem to do bus-to-CPU
conversions on P2P bridge windows, but not on endpoint BARs.

Is it really the case that the OF device tree has bus addresses for
P2P windows but CPU addresses for other BARs?  That would be
surprising to me.  Or did I miss a conversion somewhere?

Help :)  Any sparc experts want to enlighten me?

Bjorn
