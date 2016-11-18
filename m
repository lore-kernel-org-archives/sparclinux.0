From: David Miller <davem@davemloft.net>
Date: Fri, 18 Nov 2016 19:29:03 +0000
Subject: Re: [PATCH v3 0/6] sparc: Enable sun4v hypervisor PCI IOMMU v2 APIs and ATU
Message-Id: <20161118.142903.2292605042494367332.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1477674765-22160-1-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1477674765-22160-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tushar.n.dave@oracle.com
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, jroedel@suse.de, egtvedt@samfundet.no, robin.murphy@arm.com, m.szyprowski@samsung.com, krzk@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Fri, 28 Oct 2016 10:12:39 -0700

> ATU (Address Translation Unit) is a new IOMMU in SPARC supported with
> sun4v hypervisor PCI IOMMU v2 APIs.
> 
> Current SPARC IOMMU supports only 32bit address ranges and one TSB
> per PCIe root complex that has a 2GB per root complex DVMA space
> limit. The limit has become a scalability bottleneck nowadays that
> a typical 10G/40G NIC can consume 500MB DVMA space per instance.
> When DVMA resource is exhausted, devices will not be usable
> since the driver can't allocate DVMA.
> 
> For example, we recently experienced legacy IOMMU limitation while
> using i40e driver in system with large number of CPUs (e.g. 128).
> Four ports of i40e, each request 128 QP (Queue Pairs). Each queue has
> 512 (default) descriptors. So considering only RX queues (because RX
> premap DMA buffers), i40e takes 4*128*512 number of DMA entries in
> IOMMU table. Legacy IOMMU can have at max (2G/8K)- 1 entries available
> in table. So bringing up four instance of i40e alone saturate existing
> IOMMU resource.
> 
> ATU removes bottleneck by allowing guest os to create IOTSB of size
> 32G (or more) with 64bit address ranges available in ATU HW. 32G is
> more than enough DVMA space to be shared by all PCIe devices under
> root complex contrast to 2G space provided by legacy IOMMU.
> 
> ATU allows PCIe devices to use 64bit DMA addressing. Devices
> which choose to use 32bit DMA mask will continue to work with the
> existing legacy IOMMU.
> 
> The patch set is tested on sun4v (T1000, T2000, T3, T4, T5, T7, S7)
> and sun4u SPARC.

Series applied, thanks.
