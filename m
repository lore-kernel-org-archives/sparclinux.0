From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 01 Apr 2015 01:08:18 +0000
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <551B4502.1020603@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>	
 <20150331180642.GA13314@oracle.com>
 <1427850091.20500.150.camel@kernel.crashing.org>
In-Reply-To: <1427850091.20500.150.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On 03/31/2015 09:01 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-03-31 at 14:06 -0400, Sowmini Varadhan wrote:
>> Having bravely said that..
>>
>> the IB team informs me that they see a 10% degradation using
>> the spin_lock as opposed to the trylock.
>>
>> one path going forward is to continue processing this patch-set
>> as is. I can investigate this further, and later revise the spin_lock
>> to the trylock, after we are certain that it is good/necessary.
>
> Have they tried using more pools instead ?


we just tried 32 instead of 16, no change to perf.

Looks like their current bottleneck is the find_next_zero_bit (they
can get a 2X perf improvement with the lock fragmentation, but are
then hitting a new ceiling, even with the trylock version)


I'm starting to wonder if  some approximation of dma premapped
buffers may be needed. Doing a map/unmap on each packet is expensive.

