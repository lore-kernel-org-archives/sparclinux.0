From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 27 Mar 2015 22:51:48 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<20150327.145016.86183910134380870.davem@davemloft.net>
In-Reply-To: <20150327.145016.86183910134380870.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, Bjorn Helgaas <bhelgaas@google.com>
Cc: David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Mar 27, 2015 at 2:50 PM, David Miller <davem@davemloft.net> wrote:

> All DMA occurs behind an IOMMU and these IOMMUs only
> support 32-bit addressing, therefore dma_addr_t is
> 32-bit on sparc64.
>
> If you want to represent PCI address in some way, you
> absolutely cannot use dma_addr_t as your data type.

Oh no, we missed that for a while.

Hi Bjorn,

I would suggest that we introduce pci_bus_addr_t or pci_addr_t.

    Yinghai
