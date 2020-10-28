From: David Hildenbrand <david@redhat.com>
Date: Wed, 28 Oct 2020 11:17:35 +0000
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map manipulation
Message-Id: <5805fdd9-14e5-141c-773b-c46d2da57258@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
 <20201026090526.GA1154158@kernel.org>
 <a0212b073b3b2f62c3dbf1bf398f03fa402997be.camel@intel.com>
 <20201027083816.GG1154158@kernel.org>
 <e5fc62b6-f644-4ed5-de5b-ffd8337861e4@redhat.com>
 <20201028110945.GE1428094@kernel.org>
In-Reply-To: <20201028110945.GE1428094@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "paulus@samba.org" <paulus@samba.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "cl@linux.com" <cl@linux.com>, "will@kernel.org" <will@kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rientjes@google.com" <rientjes@google.com>, "Brown,
 Len" <len.brown@intel.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "kirill@shutemov.name" <kirill@shutemov.name>, "tglx@linutronix.de" <tglx@linutronix.de>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "davem@davemloft.net" <davem@davemloft.net>

On 28.10.20 12:09, Mike Rapoport wrote:
> On Tue, Oct 27, 2020 at 09:46:35AM +0100, David Hildenbrand wrote:
>> On 27.10.20 09:38, Mike Rapoport wrote:
>>> On Mon, Oct 26, 2020 at 06:05:30PM +0000, Edgecombe, Rick P wrote:
>>>
>>>> Beyond whatever you are seeing, for the latter case of new things
>>>> getting introduced to an interface with hidden dependencies... Another
>>>> edge case could be a new caller to set_memory_np() could result in
>>>> large NP pages. None of the callers today should cause this AFAICT, but
>>>> it's not great to rely on the callers to know these details.
> 
>>> A caller of set_memory_*() or set_direct_map_*() should expect a failure
>>> and be ready for that. So adding a WARN to safe_copy_page() is the first
>>> step in that direction :)
>>>
>>
>> I am probably missing something important, but why are we saving/restoring
>> the content of pages that were explicitly removed from the identity mapping
>> such that nobody will access them?
> 
> Actually, we should not be saving/restoring free pages during
> hibernation as there are several calls to mark_free_pages() that should
> exclude the free pages from the snapshot. I've tried to find why the fix
> that maps/unmaps a page to save it was required at the first place, but
> I could not find bug reports.
> 
> The closest I've got is an email from Rafael that asked to update
> "hibernate: handle DEBUG_PAGEALLOC" patch:
> 
> https://lore.kernel.org/linux-pm/200802200133.44098.rjw@sisk.pl/
> 
> Could it be that safe_copy_page() tries to workaround a non-existent
> problem?
> 

Clould be! Also see

https://lkml.kernel.org/r/38de5bb0-5559-d069-0ce0-daec66ef2746@suse.cz

which restores free page content based on more kernel parameters, not 
based on the original content.

-- 
Thanks,

David / dhildenb
