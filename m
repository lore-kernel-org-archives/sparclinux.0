From: David Miller <davem@davemloft.net>
Date: Thu, 24 Mar 2016 19:16:54 +0000
Subject: Re: [PATCH v3] sparc/PCI: Fix for panic while enabling SR-IOV
Message-Id: <20160324.151654.1707693980081136191.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1458772676-47866-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1458772676-47866-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: bhelgaas@google.com, wangyijing@huawei.com, sowmini.varadhan@oracle.com, jiang.liu@linux.intel.com, eric.snowberg@oracle.com, yinghai@kernel.org, dan.j.williams@intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, ethan.zhao@oracle.com

From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 23 Mar 2016 15:37:56 -0700

> +#ifdef CONFIG_PCI_IOV
> +int pcibios_add_device(struct pci_dev *dev)
> +{
> +	struct pci_dev *pdev;
> +	/*
> +	 * Add sriov arch specific initialization here.
> +	 * Copy dev_archdata from PF to VF
> +	 */

Always have an empty line after a set of local variable declarations.

Sparc code is to have comments formatted:

	/* Like
	 * this.
	 */

> +		memcpy(&dev->dev.archdata, &pdev->dev.archdata,
> +				sizeof(struct dev_archdata));

Sparc code should indent multi-line expressions by having the second
and subsequent line be indented exactly to the column following the
openning parenthesis on the first line.

You must use the appropriate number of TAB then SPACE characters
necessary to do so.

Thanks.
