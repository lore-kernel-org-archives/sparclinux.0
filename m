From: David Miller <davem@davemloft.net>
Date: Tue, 18 Aug 2015 19:10:04 +0000
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-Id: <20150818.121004.1891242587946602543.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
	<20150818184943.GA26431@google.com>
In-Reply-To: <20150818184943.GA26431@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee, sparclinux@vger.kernel.org, eric.snowberg@oracle.com, benh@kernel.crashing.org

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Aug 2015 13:49:43 -0500

> [+cc Dave, Eric, Ben, sparclinux]
> 
> On Mon, Aug 17, 2015 at 06:47:58PM +0800, Yijing Wang wrote:
>> Commit d0751b98dfa3 ("PCI: Add dev->has_secondary_link to
>> track downstream PCIe links")assumed root port is always
>> the top device in pcie tree. But on sparc64 V245 and T2000
>> the pcie tree has no root port device in top level, the
>> upstream port device is connected directly to root bus.
>> So we may get NULL parent for this upstream port device.
>> 
>> Upstream port ------ Downstream port ------PCIe-PCI bridge
> 
> This is an unusual, possibly even illegal, PCIe topology because it
> lacks a Root Port at the top of the hierarchy.  From lspci output [1]
> collected by Meelis, the top-level devices are:

The root port is in the PCI controller on sparc64, and PCI controllers
don't have actual real PCI configuration space available.

I used to put dummy PCI bus nodes into the tree and do provide dummy
software PCI config space methods, but that caused more harm than
good.

So you'll have to accomodate situations where the root port is not
there in the Linux kernel PCI bus hierarchy.
