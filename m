From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Date: Mon, 12 Nov 2018 15:12:13 +0000
Subject: Re: [mm PATCH v5 7/7] mm: Use common iterator for deferred_init_pages and deferred_free_pages
Message-Id: <ce8504f0-5963-7415-8e8d-7454b0e68fe5@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145280115.30046.13334106887516645119.stgit@ahduyck-desk1.jf.intel.com>
 <20181110041338.7ttram7po7a2ssz7@xakep.localdomain>
In-Reply-To: <20181110041338.7ttram7po7a2ssz7@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, davem@davemloft.net, pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org, kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net, yi.z.zhang@linux.intel.com

On 11/9/2018 8:13 PM, Pavel Tatashin wrote:
> On 18-11-05 13:20:01, Alexander Duyck wrote:
>> +static unsigned long __next_pfn_valid_range(unsigned long *i,
>> +					    unsigned long end_pfn)
>>   {
>> -	if (!pfn_valid_within(pfn))
>> -		return false;
>> -	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
>> -		return false;
>> -	return true;
>> +	unsigned long pfn = *i;
>> +	unsigned long count;
>> +
>> +	while (pfn < end_pfn) {
>> +		unsigned long t = ALIGN(pfn + 1, pageblock_nr_pages);
>> +		unsigned long pageblock_pfn = min(t, end_pfn);
>> +
>> +#ifndef CONFIG_HOLES_IN_ZONE
>> +		count = pageblock_pfn - pfn;
>> +		pfn = pageblock_pfn;
>> +		if (!pfn_valid(pfn))
>> +			continue;
>> +#else
>> +		for (count = 0; pfn < pageblock_pfn; pfn++) {
>> +			if (pfn_valid_within(pfn)) {
>> +				count++;
>> +				continue;
>> +			}
>> +
>> +			if (count)
>> +				break;
>> +		}
>> +
>> +		if (!count)
>> +			continue;
>> +#endif
>> +		*i = pfn;
>> +		return count;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>> +#define for_each_deferred_pfn_valid_range(i, start_pfn, end_pfn, pfn, count) \
>> +	for (i = (start_pfn),						     \
>> +	     count = __next_pfn_valid_range(&i, (end_pfn));		     \
>> +	     count && ({ pfn = i - count; 1; });			     \
>> +	     count = __next_pfn_valid_range(&i, (end_pfn)))
> 
> Can this be improved somehow? It took me a while to understand this
> piece of code. i is actually end of block, and not an index by PFN, ({pfn = i - count; 1;}) is
> simply hard to parse. Why can't we make __next_pfn_valid_range() to
> return both end and a start of a block?

One thing I could do is flip the direction and work from the end to the 
start. If I did that then 'i' and 'pfn' would be the same value and I 
wouldn't have to do the subtraction. If that works for you I could 
probably do that and it may actually be more efficient.

Otherwise I could probably pass pfn as a reference, and compute it in 
the case where count is non-zero.

> The rest is good:
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Thank you,
> Pasha
> 
