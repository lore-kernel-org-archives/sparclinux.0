From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 22 May 2018 13:02:17 +0000
Subject: Re: [PATCH v1 0/4] sparc/PCI: VGA resource and other fixes
Message-Id: <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Meelis Roos <mroos@linux.ee>, sparclinux@vger.kernel.org

[+cc sparclinux, sorry I missed this first time around]

On Mon, May 21, 2018 at 07:30:29PM -0500, Bjorn Helgaas wrote:
> The main thing here is the first patch, a legacy VGA framebuffer fix for
> issues reported by Meelis.
> 
> The others are to converge the pci_enable_device() path for LEON and PCIC
> with other arches (including sparc64), and to convert some logging to use
> dev_printk() and make it more consistent with the PCI core.
> 
> I propose to merge these via the PCI tree.
> 
> ---
> 
> Bjorn Helgaas (4):
>       sparc/PCI: Request legacy VGA framebuffer only for VGA devices
>       sparc32/PCI/LEON: Converge device enable path
>       sparc32/PCI/PCIC: Converge device enable path
>       sparc/PCI: Use dev_printk() when possible
> 
> 
>  arch/sparc/kernel/leon_pci.c   |   62 ++++++------------
>  arch/sparc/kernel/pci.c        |  136 +++++++++++++++++++++++++---------------
>  arch/sparc/kernel/pci_common.c |   31 ++-------
>  arch/sparc/kernel/pci_msi.c    |   10 +--
>  arch/sparc/kernel/pcic.c       |   86 ++++++++++++-------------
>  5 files changed, 159 insertions(+), 166 deletions(-)
