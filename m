From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 25 Jan 2017 22:50:36 +0000
Subject: Re: [PATCH v5 4/4] sparc64: Add support for ADI (Application Data Integrity)
Message-Id: <19f33a99-e719-a2a5-4330-390ed7755315@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1485362562.git.khalid.aziz@oracle.com>
 <0b6865aabc010ee3a7ea956a70447abbab53ea70.1485362562.git.khalid.aziz@oracle.com>
 <154bc417-6333-f9ac-653b-9ed280f08450@oracle.com>
 <f5d8c6c8-07cd-3a28-f457-f965eea5495d@oracle.com>
In-Reply-To: <f5d8c6c8-07cd-3a28-f457-f965eea5495d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net
Cc: viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, mike.kravetz@oracle.com, akpm@linux-foundation.org, mingo@kernel.org, kirill.shutemov@linux.intel.com, adam.buchbinder@gmail.com, hughd@google.com, minchan@kernel.org, keescook@chromium.org, chris.hyser@oracle.com, atish.patra@oracle.com, cmetcalf@mellanox.com, atomlin@redhat.com, jslaby@suse.cz, joe@perches.com, paul.gortmaker@windriver.com, mhocko@suse.com, lstoakes@gmail.com, jack@suse.cz, dave.hansen@linux.intel.com, vbabka@suse.cz, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Khalid Aziz <khalid@gonehiking.org>

On 01/25/2017 03:20 PM, Khalid Aziz wrote:
> On 01/25/2017 03:00 PM, Rob Gardner wrote:
>> On 01/25/2017 12:57 PM, Khalid Aziz wrote:
>>>
>>> @@ -157,6 +158,24 @@ int __get_user_pages_fast(unsigned long start,
>>> int nr_pages, int write,
>>>       pgd_t *pgdp;
>>>       int nr = 0;
>>>   +#ifdef CONFIG_SPARC64
>>> +    if (adi_capable()) {
>>> +        long addr = start;
>>> +
>>> +        /* If userspace has passed a versioned address, kernel
>>> +         * will not find it in the VMAs since it does not store
>>> +         * the version tags in the list of VMAs. Storing version
>>> +         * tags in list of VMAs is impractical since they can be
>>> +         * changed any time from userspace without dropping into
>>> +         * kernel. Any address search in VMAs will be done with
>>> +         * non-versioned addresses. Ensure the ADI version bits
>>> +         * are dropped here by sign extending the last bit before
>>> +         * ADI bits. IOMMU does not implement version tags.
>>> +         */
>>> +        addr = (addr << (long)adi_nbits()) >> (long)adi_nbits();
>>
>>
>> So you are depending on the sign extension to clear the ADI bits... but
>> this only happens if there is a zero in that "last bit before ADI bits".
>> If the last bit is a 1, then the ADI bits will be set instead of
>> cleared.  That seems like an unintended consequence given the comment. I
>> am aware of the value of adi_nbits() and of the number of valid bits in
>> a virtual address on the M7 processor, but wouldn't using 'unsigned
>> long' for everything here guarantee the ADI bits get cleared regardless
>> of the state of the last non-adi bit?
>
> Sign extension is the right thing to do. MMU considers values of 0 and 
> 15 for bits 63-60 to be untagged addresses and expects bit 59 to be 
> sign-extended for untagged virtual addresses. The code I added is 
> explicitly meant to sign-extend, not zero out the top 4 bits.

OK, that wasn't perfectly clear from the comment, which said "version 
bits are dropped".

So sign extending will produce an address that the MMU can use, but will 
it produce an address that will allow a successful search in the page 
tables? ie, was this same sign extending done when first handing out 
that virtual address to the user?

Rob



