From: Dave Hansen <dave.hansen@intel.com>
Date: Wed, 06 Mar 2019 21:17:38 +0000
Subject: Re: [PATCH v5 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
Message-Id: <5058428f-f351-ce26-7348-3b2255e5425d@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-5-alex@ghiti.fr>
 <7c81abe0-5f9d-32f9-1e9a-70ab06d48f8e@intel.com>
 <82a3f572-e9c1-0151-3d7d-a646f5e5302c@ghiti.fr>
In-Reply-To: <82a3f572-e9c1-0151-3d7d-a646f5e5302c@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alex Ghiti <alex@ghiti.fr>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On 3/6/19 12:08 PM, Alex Ghiti wrote:
>>>
>>> +    /*
>>> +     * Gigantic pages allocation depends on the capability for large
>>> page
>>> +     * range allocation. If the system cannot provide
>>> alloc_contig_range,
>>> +     * allow users to free gigantic pages.
>>> +     */
>>> +    if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>>> +        spin_lock(&hugetlb_lock);
>>> +        if (count > persistent_huge_pages(h)) {
>>> +            spin_unlock(&hugetlb_lock);
>>> +            return -EINVAL;
>>> +        }
>>> +        goto decrease_pool;
>>> +    }
>> We talked about it during the last round and I don't seen any mention of
>> it here in comments or the changelog: Why is this a goto?  Why don't we
>> just let the code fall through to the "decrease_pool" label?  Why is
>> this new block needed at all?  Can't we just remove the old check and
>> let it be?
> 
> I'll get rid of the goto, I don't know how to justify it properly in a
> comment,
> maybe because it is not necessary.
> This is not a new block, this means exactly the same as before (remember
> gigantic_page_supported() actually meant CONTIG_ALLOC before this series),
> except that now we allow a user to free boottime allocated gigantic pages.
> And no we cannot just remove the check and let it be since it would modify
> the current behaviour, which is to return an error when trying to allocate
> gigantic pages whereas alloc_contig_range is not defined. I thought it was
> clearly commented above, I can try to make it more explicit.

OK, that makes sense.  Could you get some of this in the changelog,
please?  Otherwise this all looks good to me.
