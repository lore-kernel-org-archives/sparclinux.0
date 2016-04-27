From: David Miller <davem@davemloft.net>
Date: Wed, 27 Apr 2016 20:38:53 +0000
Subject: Re: [PATCH] sparc/pci: Refactor dev_archdata initialization into pci_init_dev_archdata
Message-Id: <20160427.163853.1641891293821574917.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160412005705.GF12906@oracle.com>
In-Reply-To: <20160412005705.GF12906@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 11 Apr 2016 17:57:05 -0700

> The function pcibios_add_device() added by commit d0c31e020057
> ("sparc/PCI: Fix for panic while enabling SR-IOV") initializes
> the dev_archdata by doing a memcpy from the PF. This has the
> problem that it erroneously copies the OF device without
> explicitly refcounting it.
> 
> As David Miller pointed out: "Generally speaking we don't
> really support hot-plug for OF probed devices, but if we did
> all of the device tree pointers have to be refcounted properly."
> 
> To fix this error, and also avoid code duplication, this patch
> creates a new helper function, pci_init_dev_archdata(), that
> initializes the fields in dev_archdata, and can be invoked
> by callers after they have taken the needed refcounts
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Tested-by: Babu Moger <babu.moger@oracle.com>

Applied.
