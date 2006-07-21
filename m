From: Chris Newport <crn@netunix.com>
Date: Fri, 21 Jul 2006 22:03:31 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <44C14F33.2020303@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>I don't think you'll get very far debugging the ESP driver.
>More likely DMA is being corrupted or similar, and this
>means you should fiddle around in the sun4d IOMMU support
>code for SBUS and make sure nothing fishy is going on there.
>-
>To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>
A year or so ago I did a few patches for Sun4d and there was a note in 
the iommu code about sun4d not having a register that was used for 
scratch data in sun4m.
Could this bug be back ?

Sorry to be vague, this is from memory.

