From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 06 Oct 2017 13:55:49 +0000
Subject: Re: [PATCH] mm: deferred_init_memmap improvements
Message-Id: <0a836d3f-1a0c-8a9e-f4b2-eeb72a08a3e3@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171004152902.17300-1-pasha.tatashin@oracle.com>
 <071d574f-1d8c-5be9-ec92-6227db01bbd3@linux.vnet.ibm.com>
In-Reply-To: <071d574f-1d8c-5be9-ec92-6227db01bbd3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Anshuman,

Thank you very much for looking at this. My reply below::

On 10/06/2017 02:48 AM, Anshuman Khandual wrote:
> On 10/04/2017 08:59 PM, Pavel Tatashin wrote:
>> This patch fixes another existing issue on systems that have holes in
>> zones i.e CONFIG_HOLES_IN_ZONE is defined.
>>
>> In for_each_mem_pfn_range() we have code like this:
>>
>> if (!pfn_valid_within(pfn)
>> 	goto free_range;
>>
>> Note: 'page' is not set to NULL and is not incremented but 'pfn' advances.
> 
> page is initialized to NULL at the beginning of the function.

Yes, it is initialized to NULL but at the beginning of 
for_each_mem_pfn_range() loop

> PFN advances but we dont proceed unless pfn_valid_within(pfn)
> holds true which basically should have checked with arch call
> back if the PFN is valid in presence of memory holes as well.
> Is not this correct ?

Correct, if pfn_valid_within() is false we jump to the "goto 
free_range;", which is at the end of for (; pfn < end_pfn; pfn++) loop, 
so we are not jumping outside of this loop.

> 
>> Thus means if deferred struct pages are enabled on systems with these kind
>> of holes, linux would get memory corruptions. I have fixed this issue by
>> defining a new macro that performs all the necessary operations when we
>> free the current set of pages.
> 
> If we bail out in case PFN is not valid, then how corruption
> can happen ?
> 

We are not bailing out. We continue next iteration with next pfn, but 
page is not incremented.

Please let me know if I am missing something.

Thank you,
Pasha
