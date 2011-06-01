From: Steven Dake <sdake@redhat.com>
Date: Wed, 01 Jun 2011 09:37:04 +0000
Subject: Re: mmap operation not working as expected on sparc linux
Message-Id: <4DE60840.900@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DE5F5B9.4020601@redhat.com>
In-Reply-To: <4DE5F5B9.4020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/01/2011 01:38 AM, David Miller wrote:
> From: Steven Dake <sdake@redhat.com>
> Date: Wed, 01 Jun 2011 01:18:01 -0700
> 
>> I maintain a project called corosync which uses a memory backed file to
>> generate a duplicate mapping in memory to implement a ring buffer.  It
>> essentially uses the concepts here:
>>
>> http://en.wikipedia.org/wiki/Ring_buffer#Exemplary_POSIX_Implementation
>>
>> This doesn't appear to work on sparclinux, returning an error EINVAL  on
>> the second memory map operation:
>>
>> address = mmap (buffer->address + buffer->count_bytes,
>>                   buffer->count_bytes, PROT_READ | PROT_WRITE,
>>                   MAP_FIXED | MAP_SHARED, file_descriptor, 0);
>>
>> Any ideas?
> 
> The start addresses of fixed and shared mappings need to have a
> certain property relative to other such mappings.
> 
> And that property is that the addresses must all be modulo the
> D-cache alias factor, which on sparc64 is 16384 bytes.
> 
> If we didn't enfore this, then writes from one mapping could get
> aliased in the L1 D-cache, and not show up in other mappings.
> 
> However if we force all the start address to the same 16K boundary,
> then this guarentees that writes to one mapping will show up in
> others.
> 
> You'll hit similar issues on MIPS, ARM, PARISC, and SH.  Just look for
> which platforms define __ARCH_FORCE_SHMLBA in their shmparam.h header
> file.

Thanks for the response.  For those searching for this problem in the
future, We tried 16384, and then decided to have a look at the kernel
source tree and came up with some speculation that the hugetlb settings
would result in EINVAL via prepare_hugetlb.  The minimum page we could
execute this operation on was 4MB.  I notice on some other arches this
is not required.

Best regards
-steve
