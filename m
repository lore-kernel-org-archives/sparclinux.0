From: David Miller <davem@davemloft.net>
Date: Thu, 24 Nov 2016 01:24:01 +0000
Subject: Re: [PATCH] qlogicpti: Fix compiler warnings
Message-Id: <20161123.202401.1859796355662824692.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1479936597-29061-1-git-send-email-tushar.n.dave@oracle.com>
        <1479941859.2417.28.camel@HansenPartnership.com>
In-Reply-To: <1479941859.2417.28.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James.Bottomley@HansenPartnership.com
Cc: tushar.n.dave@oracle.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org, thomas.tai@oracle.com, sparclinux@vger.kernel.org

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 23 Nov 2016 14:57:39 -0800

> What's the guarantee, since the device descriptors only cope with 32
> bits of physical address, that this driver never gets any dma address
> beyond its addressable range?  Is it that the sbus can never be
> attached to this ATU type IOMMU?  If so, saying that in the log would
> be useful.

SBUS hasn't changed for 20 years and is a 32-bit bus.
