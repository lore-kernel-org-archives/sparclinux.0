From: David Miller <davem@davemloft.net>
Date: Thu, 20 Aug 2015 17:51:20 +0000
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-Id: <20150820.105120.2282063631702003363.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1440023349.2737.21.camel@kernel.crashing.org>
	<CAErSpo7JtRLWRAUPBdsoKauHNmftsb6fST317V9Sg4PkTV91pg@mail.gmail.com>
	<CALMQjD_d+S4e1OLhMDdt6PTn8Bfm3o9ZqXJxitcVtzE+hSrs+A@mail.gmail.com>
In-Reply-To: <CALMQjD_d+S4e1OLhMDdt6PTn8Bfm3o9ZqXJxitcVtzE+hSrs+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: oftedal@gmail.com
Cc: bhelgaas@google.com, benh@kernel.crashing.org, wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee, sparclinux@vger.kernel.org, eric.snowberg@oracle.com

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Thu, 20 Aug 2015 08:44:45 +0200

> Less assumptions made on the basis of the PCIe spec might prevent
> some of this breakage?

+1
