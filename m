From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 07 Feb 2018 07:38:40 +0000
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced by SPARC M7
Message-Id: <87h8qtfdvj.fsf@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
	<87wozwi0p1.fsf@xmission.com>
	<0f1bdb63-60d5-467c-a6a4-c06ba62b1f6e@oracle.com>
In-Reply-To: <0f1bdb63-60d5-467c-a6a4-c06ba62b1f6e@oracle.com> (Khalid Aziz's
	message of "Fri, 2 Feb 2018 07:59:25 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, aarcange@redhat.com, akpm@linux-foundation.org, allen.pais@oracle.com, anthony.yznaga@oracle.com, arnd@arndb.de, babu.moger@oracle.com, benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com, corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com, david.j.aldridge@oracle.com, elena.reshetova@intel.com, glx@linutronix.de, gregkh@linuxfoundation.org, hannes@cmpxchg.org, hillf.zj@alibaba-inc.com, hpa@zytor.com, hughd@google.com, imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com, jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de, khalid@gonehiking.org, khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org, ktkhai@virtuozzo.com, liam.merwick@oracle.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vg

Khalid Aziz <khalid.aziz@oracle.com> writes:

> On 02/01/2018 07:29 PM, ebiederm@xmission.com wrote:
>> Khalid Aziz <khalid.aziz@oracle.com> writes:
>>
>>> V11 changes:
>>> This series is same as v10 and was simply rebased on 4.15 kernel. Can
>>> mm maintainers please review patches 2, 7, 8 and 9 which are arch
>>> independent, and include/linux/mm.h and mm/ksm.c changes in patch 10
>>> and ack these if everything looks good?
>>
>> I am a bit puzzled how this differs from the pkey's that other
>> architectures are implementing to achieve a similar result.
>>
>> I am a bit mystified why you don't store the tag in a vma
>> instead of inventing a new way to store data on page out.
>
> Hello Eric,
>
> As Steven pointed out, sparc sets tags per cacheline unlike pkey. This results
> in much finer granularity for tags that pkey and hence requires larger tag
> storage than what we can do in a vma.

*Nod*   I am a bit mystified where you keep the information in memory.
I would think the tags would need to be stored per cacheline or per
tlb entry, in some kind of cache that could overflow.  So I would be
surprised if swapping is the only time this information needs stored
in memory.  Which makes me wonder if you have the proper data
structures.

I would think an array per vma or something in the page tables would
tend to make sense.

But perhaps I am missing something.

>> Can you please use force_sig_fault to send these signals instead
>> of force_sig_info.  Emperically I have found that it is very
>> error prone to generate siginfo's by hand, especially on code
>> paths where several different si_codes may apply.  So it helps
>> to go through a helper function to ensure the fiddly bits are
>> all correct.  AKA the unused bits all need to be set to zero before
>> struct siginfo is copied to userspace.
>>
>
> What you say makes sense. I followed the same code as other fault handlers for
> sparc. I could change just the fault handlers for ADI related faults. Would it
> make more sense to change all the fault handlers in a separate patch and keep
> the code in arch/sparc/kernel/traps_64.c consistent? Dave M, do you have a
> preference?

It is my intention post -rc1 to start sending out patches to get the
rest of not just sparc but all of the architectures using the new
helpers.  I have the code I just ran out of time befor the merge
window opened to ensure everything had a good thorough review.

So if you can handle the your new changes I expect I will handle the
rest.

Eric
