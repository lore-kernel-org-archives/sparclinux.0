From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 06 Apr 2015 22:49:13 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <20150406224913.GI10892@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-4-git-send-email-yinghai@kernel.org>
 <20150406220638.GH10892@google.com>
 <CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
In-Reply-To: <CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Mon, Apr 06, 2015 at 03:35:40PM -0700, Yinghai Lu wrote:
> On Mon, Apr 6, 2015 at 3:06 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> > But this is a general change that affects all platforms, and it's late in
> > the cycle for something as invasive as this.  I'd rather include your patch
> > in the v4.1 merge window, and revert d63e2e1f3df9 ("sparc/PCI: Clip bridge
> > windows to fit in upstream windows") for v4.0.
> 
> How about applying first two in this patchset for v4.0, and leaving
> this one for v4.1?

For "[PATCH 1/3] PCI: Introduce pci_bus_addr_t", I'm waiting for an updated
version with Kconfig tweaks so we don't break other arches.

For "[PATCH 2/3] sparc/PCI: Add mem64 resource parsing for root bus", I'm
waiting for a version that fixes the other of_bus_pci_get_flags() and
pci_parse_of_flags() implementations at the same time (or an explanation
about why we should fix only the arch/sparc version).  I don't want to fix
one place and leave the same bug in other places.

Bjorn
