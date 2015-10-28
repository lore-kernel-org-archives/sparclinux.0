From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2015 02:30:28 +0000
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-Id: <20151028023028.GI7716@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com>
 <562F1368.1030204@ozlabs.ru>
 <20151027222706.GF7716@linux.vnet.ibm.com>
 <56301E24.1060304@ozlabs.ru>
 <20151028015451.GH7716@linux.vnet.ibm.com>
 <1445998805.1856.24.camel@kernel.crashing.org>
In-Reply-To: <1445998805.1856.24.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 28.10.2015 [11:20:05 +0900], Benjamin Herrenschmidt wrote:
> On Tue, 2015-10-27 at 18:54 -0700, Nishanth Aravamudan wrote:
> > 
> > In "bypass" mode, what TCE size is used? Is it guaranteed to be 4K?
> 
> None :-) The TCEs are completely bypassed. You get a N:M linear mapping
> of all memory starting at 1<<59 PCI side.

Err, duh, sorry! Ok, so in that case, DMA page shift is PAGE_SHIFT,
then?

-Nish

