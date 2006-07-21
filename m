From: Raymond Burns <rayburns@comcast.net>
Date: Fri, 21 Jul 2006 22:33:51 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <Pine.LNX.4.10.10607211532470.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 21 Jul 2006, David Miller wrote:

> 
> I don't think you'll get very far debugging the ESP driver.
> More likely DMA is being corrupted or similar, and this
> means you should fiddle around in the sun4d IOMMU support
> code for SBUS and make sure nothing fishy is going on there.

Thats the hint I'm looking for, Thank You  :)

Thanx
  Ray


