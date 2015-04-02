From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 02 Apr 2015 22:02:59 +0000
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <1428012179.20500.280.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150402214343.GA15680@oracle.com>
 <1428011820.20500.277.camel@kernel.crashing.org>
 <1428012097.20500.279.camel@kernel.crashing.org>
In-Reply-To: <1428012097.20500.279.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Fri, 2015-04-03 at 09:01 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2015-04-03 at 08:57 +1100, Benjamin Herrenschmidt wrote:
> 
> > No, the last argument to iommu_area_alloc() which is passed from the
> > callers when doing consistent allocs. Basically, the DMA api mandates
> > that consistent allocs are naturally aligned (to their own size), we
> > implement that on powerpc by passing that alignment argument down.
> 
> Talking of this ... I notice this is not documented in DMA-API.txt...
> however many drivers make that assumption, and the DMA pool allocator
> in mm/dmapool.c as well.
> 
> Maybe somebody should update DMA-API.txt...

Ah it *is* documented in DMA-API-HOWTO.txt :-)

Cheers,
Ben.


