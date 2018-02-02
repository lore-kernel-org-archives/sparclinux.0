From: Steven Sistare <steven.sistare@oracle.com>
Date: Fri, 02 Feb 2018 14:13:08 +0000
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced by SPARC M7
Message-Id: <59fb3a0c-0163-0ec2-9757-cc5969601fa7@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
 <87wozwi0p1.fsf@xmission.com>
In-Reply-To: <87wozwi0p1.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, aarcange@redhat.com, akpm@linux-foundation.org, allen.pais@oracle.com, anthony.yznaga@oracle.com, arnd@arndb.de, babu.moger@oracle.com, benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com, corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com, david.j.aldridge@oracle.com, elena.reshetova@intel.com, glx@linutronix.de, gregkh@linuxfoundation.org, hannes@cmpxchg.org, hillf.zj@alibaba-inc.com, hpa@zytor.com, hughd@google.com, imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com, jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de, khalid@gonehiking.org, khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org, ktkhai@virtuozzo.com, liam.merwick@oracle.com

On 2/1/2018 9:29 PM, ebiederm@xmission.com wrote:
> Khalid Aziz <khalid.aziz@oracle.com> writes:
> 
>> V11 changes:
>> This series is same as v10 and was simply rebased on 4.15 kernel. Can
>> mm maintainers please review patches 2, 7, 8 and 9 which are arch
>> independent, and include/linux/mm.h and mm/ksm.c changes in patch 10
>> and ack these if everything looks good?
> 
> I am a bit puzzled how this differs from the pkey's that other
> architectures are implementing to achieve a similar result.
> 
> I am a bit mystified why you don't store the tag in a vma
> instead of inventing a new way to store data on page out.
> 
> Can you please use force_sig_fault to send these signals instead
> of force_sig_info.  Emperically I have found that it is very
> error prone to generate siginfo's by hand, especially on code
> paths where several different si_codes may apply.  So it helps
> to go through a helper function to ensure the fiddly bits are
> all correct.  AKA the unused bits all need to be set to zero before
> struct siginfo is copied to userspace.
> 
> Eric

The ADI tag can be set at a cacheline (64B) granularity, as opposed
to the per-page granularity of pkeys.  This allows an object allocator
to color each object differently within a page (rounding to 64B boundaries),
such that a pointer overrun bug from one object to the next will cause a
fault.  When pages are paged out, the tags must be saved, hence the
new scheme for storing them.  One tag per vma is too coarse.

The combination of fine granularity and pageability makes for a powerful
memory-reference error-detection framework.

This was discussed in more detail when earlier patches were submitted,
but it's been a while, and the distribution was probably narrower.

Khalid can respond to the sig_fault comment.

- Steve
