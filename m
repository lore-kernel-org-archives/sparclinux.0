From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 26 Mar 2015 10:56:01 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150326105601.GK31861@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323.214453.255192641139042325.davem@davemloft.net>
 <1427162890.4770.307.camel@kernel.crashing.org>
 <20150323.221508.1178754097347144400.davem@davemloft.net>
 <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
In-Reply-To: <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cascardo@linux.vnet.ibm.com
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

On (03/25/15 21:43), cascardo@linux.vnet.ibm.com wrote:
> However, when using large TCP send/recv (I used uperf with 64KB
> writes/reads), I noticed that on the transmit side, largealloc is not
> used, but on the receive side, cxgb4 almost only uses largealloc, while
> qlge seems to have a 1/1 usage or largealloc/non-largealloc mappings.
> When turning GRO off, that ratio is closer to 1/10, meaning there is
> still some fair use of largealloc in that scenario.
> 
> I confess my experiments are not complete. I would like to test a couple
> of other drivers as well, including mlx4_en and bnx2x, and test with
> small packet sizes. I suspected that MTU size could make a difference,
> but in the case of ICMP, with MTU 9000 and payload of 8000 bytes, I
> didn't notice any significant hit of largepool with either qlge or
> cxgb4.

I guess we also need to consider the "average use-case", i.e., 
something that interleaves small packets and interactive data with
jumbo/bulk data.. in those cases, the largepool would not get many
hits, and might actually be undesirable?

> But I believe that on the receive side, all drivers should map entire
> pages, using some allocation strategy similar to mlx4_en, in order to
> avoid DMA mapping all the time. 

good point. I think in the early phase of my perf investigation,
it was brought up that Solaris does pre-mapped DMA buffers (they
have to do this carefully, to avoid resource-starvation vulnerabilities-
see http://www.spinics.net/lists/sparclinux/msg13217.html
and threads leading to it..

This is  not something that the common iommu-arena allocator
can/should get involved in, of course. The scope of the arena-allocator
is much more rigorously defined.

I dont know if there is a way to set up a generalized DMA premapped
buffer infra for linux today.

fwiw, when I instrumented this for solaris (there are hooks to disable
the pre-mapped bufferes) the impact on a T5-2 (8 sockets, 2 numa nodes,
64 cpus) was not very significant for a single 10G ixgbe port- approx
8 Gbps instead of 9.X Gbps. I think the DMA buffer pre-mapping is
only significant when you start trying to scale to multiple ethernet 
ports.

--Sowmini

