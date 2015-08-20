From: David Miller <davem@davemloft.net>
Date: Thu, 20 Aug 2015 17:47:28 +0000
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-Id: <20150820.104728.699050706854625548.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
	<20150820054800.GB10267@google.com>
In-Reply-To: <20150820054800.GB10267@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee, sparclinux@vger.kernel.org, eric.snowberg@oracle.com, benh@kernel.crashing.org

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 00:48:00 -0500

> [+cc Dave, Eric, Ben, sparclinux]

I think the comment is terrible.

It is not limited to those two systems, it is a general problem with
how the code assumes the root PCI-E port is instantiated in the PCI
bus hierarchy which will not be true on any system which has a PCI
controller that doesn't actually provide a bonafide config space to
access.

