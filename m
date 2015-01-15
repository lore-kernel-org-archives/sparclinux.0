From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 15 Jan 2015 22:15:45 +0000
Subject: Re: [PATCH 10/10] PCI, sparc: clip firmware assigned resource under parent bridge's
Message-Id: <20150115221545.GA29776@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1421090600-9750-1-git-send-email-yinghai@kernel.org>
 <1421090600-9750-11-git-send-email-yinghai@kernel.org>
 <CALMQjD91+0o=DjQDV3ydkakrG6X=3RkHoCf-T5=wLbC01WkdEA@mail.gmail.com>
In-Reply-To: <CALMQjD91+0o=DjQDV3ydkakrG6X=3RkHoCf-T5=wLbC01WkdEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Kjetil Oftedal <oftedal@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, Yijing Wang <wangyijing@huawei.com>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org

On Mon, Jan 12, 2015 at 11:31:09PM +0100, Kjetil Oftedal wrote:
> Hi,
>=20
> Am I missing something or is this just code to get the the resource
> subsystem to accept the bus resources, not caring if the resources are
> actually usable? PCI BARs usually have a given size for a reason?

Hi Kjetil,

This isn't for regular PCI BARs (Yinghai did apply it to some regular BARs
in the v1 patches, but I think that was a mistake).  This is for scenarios
like this:

  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff]
  pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff 64bit pref]
  pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]

The 00:01.0 window is illegal: it starts before the host bridge window, so
we have to assume the [0xbdf00000-0xbfffffff] region is inaccessible.  We
can make it legal by clipping it to [mem 0xc0000000-0xddefffff 64bit pref].

Linux should never assign an illegal bridge window like this, but some
firmware does, and the idea is to make a minimal change (clip the window)
before resorting to the big hammer of reassigning resources from scratch.

Bjorn

> On 12/01/2015, Yinghai Lu <yinghai@kernel.org> wrote:
> > Some bios put range that is not fully coverred by root bus resources.
> > Try to clip them and update them in pci bridge bars.
> >
> > We'd like to fix other arches instead of just x86.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
> > Reported-by: Marek Kordik <kordikmarek@gmail.com>
> > Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows =
to
> > 64-bit resources")
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Cc: Yijing Wang <wangyijing@huawei.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: sparclinux@vger.kernel.org
> > ---
> >  arch/sparc/kernel/pci.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> > index b36365f..0e391e5 100644
> > --- a/arch/sparc/kernel/pci.c
> > +++ b/arch/sparc/kernel/pci.c
> > @@ -623,6 +623,7 @@ static void pci_claim_bus_resources(struct pci_bus
> > *bus)
> >  	struct pci_dev *dev;
> >
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> > +		bool changed =3D false;
> >  		int i;
> >
> >  		for (i =3D 0; i < PCI_NUM_RESOURCES; i++) {
> > @@ -639,8 +640,25 @@ static void pci_claim_bus_resources(struct pci_bus
> > *bus)
> >  				       (unsigned long long)r->end,
> >  				       (unsigned int)r->flags);
> >
> > -			pci_claim_resource(dev, i);
> > +			if (pci_claim_resource(dev, i) >=3D 0)
> > +				continue;
> > +
> > +			if (dev->subordinate &&
> > +			    i >=3D PCI_BRIDGE_RESOURCES &&
> > +			    i < PCI_NUM_RESOURCES &&
> > +			    (dev->class >> 8) =3D PCI_CLASS_BRIDGE_PCI &&
> > +			    pci_bus_clip_resource(dev, r)) {
> > +				changed =3D true;
> > +				pci_claim_resource(dev, i);
> > +			} else if (i < PCI_BRIDGE_RESOURCES &&
> > +				   i !=3D PCI_ROM_RESOURCE &&
> > +				   pci_bus_clip_resource(dev, r)) {
> > +					pci_update_resource(dev, i);
> > +					pci_claim_resource(dev, i);
> > +			}
> >  		}
> > +		if (changed)
> > +			pci_setup_bridge(dev->subordinate);
> >  	}
> >
> >  	list_for_each_entry(child_bus, &bus->children, node)
> > --
> > 1.8.4.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
