From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 07 Apr 2015 01:13:54 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <CAE9FiQWGqjyp9YABc=BvzFSm7Tj7reojOoMPDybQZ1RYXD8XZQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-4-git-send-email-yinghai@kernel.org>
	<20150406220638.GH10892@google.com>
	<CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
	<20150406224913.GI10892@google.com>
In-Reply-To: <20150406224913.GI10892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Mon, Apr 6, 2015 at 3:49 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> For "[PATCH 1/3] PCI: Introduce pci_bus_addr_t", I'm waiting for an updated
> version with Kconfig tweaks so we don't break other arches.

I was thinking that you will update it manually.

>
> For "[PATCH 2/3] sparc/PCI: Add mem64 resource parsing for root bus", I'm
> waiting for a version that fixes the other of_bus_pci_get_flags() and
> pci_parse_of_flags() implementations at the same time (or an explanation
> about why we should fix only the arch/sparc version).  I don't want to fix
> one place and leave the same bug in other places.

I don't even know if other arch like powerpc support 64-bit bus address.

No one from powerpc reported a problem, why should we mess it up now?

I would like to see someone get access those three kinds of machine that support
of to unify of support code.

Thanks

Yinghai
