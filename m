From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Aug 2015 18:49:43 +0000
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-Id: <20150818184943.GA26431@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, mroos@linux.ee, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Eric Snowberg <eric.snowberg@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

[+cc Dave, Eric, Ben, sparclinux]

On Mon, Aug 17, 2015 at 06:47:58PM +0800, Yijing Wang wrote:
> Commit d0751b98dfa3 ("PCI: Add dev->has_secondary_link to
> track downstream PCIe links")assumed root port is always
> the top device in pcie tree. But on sparc64 V245 and T2000
> the pcie tree has no root port device in top level, the
> upstream port device is connected directly to root bus.
> So we may get NULL parent for this upstream port device.
> 
> Upstream port ------ Downstream port ------PCIe-PCI bridge

This is an unusual, possibly even illegal, PCIe topology because it
lacks a Root Port at the top of the hierarchy.  From lspci output [1]
collected by Meelis, the top-level devices are:

  0000:02:00.0 PCI bridge to [bus 03-0d]    Upstream Port
  0001:02:00.0 PCI bridge to [bus 03]       PCIe to PCI/PCI-X Bridge
  0001:02:00.2 PCI bridge to [bus 04]       PCIe to PCI/PCI-X Bridge

There *should* be two Root Ports, one leading to 0000:02 and another
leading to 0001:02.1

I suspect this is an artifact of the way sparc and powerpc use OF to
enumerate PCI.  I suspect there actually *is* a Root Port in the
hardware: why would the hardware designers go to the trouble of
working out special-case rules and behavior for a non-standard PCIe
hierarchy when it would be much easier to reuse existing hardware?

As long as the Root Port is configured correctly, Linux can pretend it
doesn't exist and things will mostly just work.  Except for a few
corner cases like this one.

I really hate to put special case workarounds like this patch in the
generic code.  It's likely that we'd trip over the same issue again in
other areas, e.g., MPS or other configuration.

Sparc & powerpc guys, any input on this?

Bjorn

[1] http://lkml.kernel.org/r/alpine.LRH.2.20.1508131111570.9039@math.ut.ee

> Reported-by: Meelis Roos <mroos@linux.ee>
> Tested-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/probe.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 51ebb97..cd54298 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1003,7 +1003,10 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	else if (type = PCI_EXP_TYPE_UPSTREAM ||
>  		 type = PCI_EXP_TYPE_DOWNSTREAM) {
>  		parent = pci_upstream_bridge(pdev);
> -		if (!parent->has_secondary_link)
> +		/* For sparc64 V245 and T2000, upstream port may be
> +		 * the top level device, connect to root bus directly.
> +		 */
> +		if (parent && !parent->has_secondary_link)
>  			pdev->has_secondary_link = 1;
>  	}
>  }
> -- 
> 1.7.1
> 
