From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2006 21:40:28 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <20060721.144028.48518771.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I don't think you'll get very far debugging the ESP driver.
More likely DMA is being corrupted or similar, and this
means you should fiddle around in the sun4d IOMMU support
code for SBUS and make sure nothing fishy is going on there.
