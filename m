From: David Miller <davem@davemloft.net>
Date: Wed, 28 Oct 2015 00:54:43 +0000
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-Id: <20151027.175443.140992924519172506.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
In-Reply-To: <20151027223643.GA25332@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Busch, Keith" <keith.busch@intel.com>
Date: Tue, 27 Oct 2015 22:36:43 +0000

> If you're suggesting to compile-time break architectures that currently
> work just fine with NVMe, let me stop you right there.

Silently "working" without the architecture maintainer having to explicity
look at the new interface and make sure his platform is implementing it
properly is an extremely bad practice.
