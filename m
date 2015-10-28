From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 28 Oct 2015 02:20:05 +0000
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-Id: <1445998805.1856.24.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com> <562F1368.1030204@ozlabs.ru>
 <20151027222706.GF7716@linux.vnet.ibm.com> <56301E24.1060304@ozlabs.ru>
 <20151028015451.GH7716@linux.vnet.ibm.com>
In-Reply-To: <20151028015451.GH7716@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2015-10-27 at 18:54 -0700, Nishanth Aravamudan wrote:
> 
> In "bypass" mode, what TCE size is used? Is it guaranteed to be 4K?

None :-) The TCEs are completely bypassed. You get a N:M linear mapping
of all memory starting at 1<<59 PCI side.

> Seems like this would be a different platform implentation I'd put in
> for 'powernv', is that right?
> 
> My apologies for missing that, and thank you for the review!

Cheers,
Ben.

