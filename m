From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Tue, 03 Mar 2020 09:25:21 +0000
Subject: Re: [RFC 3/3] mm/vma: Introduce some more VMA flag wrappers
Message-Id: <ce7dd2ac-26e8-d83c-46d0-0c61609be417@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
 <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
 <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2003022212090.1344@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org



On 03/03/2020 12:04 PM, Hugh Dickins wrote:
> On Mon, 2 Mar 2020, Anshuman Khandual wrote:
> 
>> This adds the following new VMA flag wrappers which will replace current
>> open encodings across various places. This should not have any functional
>> implications.
>>
>> vma_is_dontdump()
>> vma_is_noreserve()
>> vma_is_special()
>> vma_is_locked()
>> vma_is_mergeable()
>> vma_is_softdirty()
>> vma_is_thp()
>> vma_is_nothp()
> 
> Why?? Please don't. I am not at all keen on your 1/3 and 2/3 (some
> of us actually like to see what the VM_ flags are where they're used,
> without having to chase through scattered wrappers hiding them),
> but this 3/3 particularly upset me.

Can understand your reservations regarding 3/3. But I had called that out
in the series cover letter that this patch can be dropped if related code
churn is not justified.

But 1/3 does create a default flag combination for VM_DATA_DEFAULT_FLAGS
with a value that is used by multiple platforms at the moment. This is
very similar to the existing VM_STACK_DEFAULT_FLAGS which has a default
value. Then why cannot VM_DATA_DEFAULT_FLAGS have one ? More over this
also saves some code duplication across platforms.

Regarding the patch 2/3, when there are many existing VMA flag overrides
like VM_STACK_FLAGS, VM_STACK_INCOMPLETE_SETUP, VM_INIT_DEF_MASK etc why
cannot a commonly used VMA flag combination with a very specific meaning
(i.e accessibility) get one. Do you have any particular concern here
which I might be missing.

> 
> There is a good reason for the (hideously named) is_vm_hugetlb_page(vma):
> to save "#ifdef CONFIG_HUGETLB_PAGE"s all over (though I suspect the
> same could have been achieved much more nicely by #define VM_HUGETLB 0);
> but hiding all flags in vma_is_whatever()s is counter-productive churn.

Makes sense, I can understand your reservation here.

> 
> Improved readability? Not to my eyes.

As mentioned before, I dont feel strongly about patch 3/3 and will drop.
