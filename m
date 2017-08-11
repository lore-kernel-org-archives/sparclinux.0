From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 15:24:55 +0000
Subject: Re: [v6 01/15] x86/mm: reserve only exiting low pages
Message-Id: <47ebf53b-ea8b-1822-a63a-3682ed2f4753@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-2-git-send-email-pasha.tatashin@oracle.com>
 <20170811080706.GC30811@dhcp22.suse.cz>
In-Reply-To: <20170811080706.GC30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> Struct pages are initialized by going through __init_single_page(). Since
>> the existing physical memory in memblock is represented in memblock.memory
>> list, struct page for every page from this list goes through
>> __init_single_page().
> 
> By a page _from_ this list you mean struct pages backing the physical
> memory of the memblock lists?

Correct: "for every page from this list...", for every page represented 
by this list the struct page is initialized through __init_single_page()

>> In this patchset we will stop zeroing struct page memory during allocation.
>> Therefore, this bug must be fixed in order to avoid random assert failures
>> caused by CONFIG_DEBUG_VM_PGFLAGS triggers.
>>
>> The fix is to reserve memory from the first existing PFN.
> 
> Hmm, I assume this is a result of some assert triggering, right? Which
> one? Why don't we need the same treatment for other than x86 arch?

Correct, the pgflags asserts were triggered when we were setting 
reserved flags to struct page for PFN 0 in which was never initialized 
through __init_single_page(). The reason they were triggered is because 
we set all uninitialized memory to ones in one of the debug patches.

>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> I guess that the review happened inhouse. I do not want to question its
> value but it is rather strange to not hear the specific review comments
> which might be useful in general and moreover even not include those
> people on the CC list so they are aware of the follow up discussion.

I will bring this up with my colleagues to how to handle this better in 
the future. I will also CC the reviewers when I sent out the updated 
patch series.
