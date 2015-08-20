From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 20:21:35 +0000
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-Id: <20150820202135.GA14810@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150820054800.GB10267@google.com>
 <20150820.104728.699050706854625548.davem@davemloft.net>
 <CAErSpo5SApFYWOs8Q2ZH2vpnEW6jY0XWAgeiyhMk4aCNtON46w@mail.gmail.com>
 <20150820.114042.1327127338658980319.davem@davemloft.net>
In-Reply-To: <20150820.114042.1327127338658980319.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee, sparclinux@vger.kernel.org, eric.snowberg@oracle.com, benh@kernel.crashing.org

On Thu, Aug 20, 2015 at 11:40:42AM -0700, David Miller wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> Date: Thu, 20 Aug 2015 11:23:43 -0700
> 
> > On Thu, Aug 20, 2015 at 10:47 AM, David Miller <davem@davemloft.net> wrote:
> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >> Date: Thu, 20 Aug 2015 00:48:00 -0500
> >>
> >>> [+cc Dave, Eric, Ben, sparclinux]
> >>
> >> I think the comment is terrible.
> > 
> > I'll update the comment if you suggest some text.  Do you object
> > mainly to the mention of the specific systems?
> 
> "PCI root complex can not be assumed to be instantiated in the PCI bus
>  hierarchy."

AIUI, the root complex itself (as distinct from root ports) doesn't
normally appear in the PCI hierarchy, so I reworded it as follows.  I hope
this helps address your objection, but if not, I can try again.

    PCI: Tolerate hierarchies with no Root Port
    
    We should not assume any particular hardware topology.  Commit d0751b98dfa3
    ("PCI: Add dev->has_secondary_link to track downstream PCIe links") relied
    on the assumption that every PCIe hierarchy is rooted at a Root Port.  But
    we can't rely on any assumption about what hardware we will find; we just
    have to deal with the world as it is.
    
    On some platforms, PCIe devices (endpoints, switch upstream ports, etc.)
    appear directly on the root bus, and there is no Root Port in the PCI bus
    hierarchy.  For example, Meelis observed these top-level devices on a
    Sparc V245:
    
      0000:02:00.0 PCI bridge to [bus 03-0d]    Switch Upstream Port
      0001:02:00.0 PCI bridge to [bus 03]       PCIe to PCI/PCI-X Bridge
    
    These devices *look* like they have links going upstream, but there really
    are no upstream devices.
    
    In set_pcie_port_type(), we used the parent device to figure out which side
    of a switch port has a link, so if the parent device did not exist, we
    dereferenced a NULL parent pointer.
    
    Check whether the parent device exists before dereferencing it.
    
    Meelis observed this oops on Sparc V245 and T2000.  Ben Herrenschmidt says
    this is also possible on IBM PowerVM guests on PowerPC.
