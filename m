From: David Miller <davem@davemloft.net>
Date: Thu, 26 Mar 2015 22:51:46 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150326.160020.1865957868633778207.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1427162890.4770.307.camel@kernel.crashing.org>
 <20150323.221508.1178754097347144400.davem@davemloft.net>
 <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
In-Reply-To: <20150326004342.GB4925@oc0812247204.ltc.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sowmini.varadhan@oracle.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: cascardo@linux.vnet.ibm.com
Date: Wed, 25 Mar 2015 21:43:42 -0300

> On Mon, Mar 23, 2015 at 10:15:08PM -0400, David Miller wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Date: Tue, 24 Mar 2015 13:08:10 +1100
>> 
>> > For the large pool, we don't keep a hint so we don't know it's
>> > wrapped, in fact we purposefully don't use a hint to limit
>> > fragmentation on it, but then, it should be used rarely enough that
>> > flushing always is, I suspect, a good option.
>> 
>> I can't think of any use case where the largepool would be hit a lot
>> at all.
> 
> Well, until recently, IOMMU_PAGE_SIZE was 4KiB on Power, so every time a
> driver mapped a whole 64KiB page, it would hit the largepool.

We don't plan to ever use 64KB page size on sparc64, so I think we're
safe there.

There are many reasons using 64KB pages is really stupid, what you
see here with the IOMMU stuff is just one of many symptoms, but I bet
your powerpc guys are kind of sick of hearing it by now... :-)

