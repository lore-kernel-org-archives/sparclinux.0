From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 28 May 2019 15:57:25 +0000
Subject: Re: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
Message-Id: <2eecb673-cb18-990e-0a61-900ecd056152@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190525133203.25853-1-hch@lst.de>
 <20190525133203.25853-5-hch@lst.de>
 <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com>
In-Reply-To: <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Nicholas Piggin <npiggin@gmail.com>, linux-mips@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On 5/25/19 11:05 AM, Linus Torvalds wrote:
> [ Adding Khalid, who added the sparc64 code ]
> 
> On Sat, May 25, 2019 at 6:32 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> This will allow sparc64 to override its ADI tags for
>> get_user_pages and get_user_pages_fast.  I have no idea why this
>> is not required for plain old get_user_pages, but it keeps the
>> existing sparc64 behavior.
> 
> This is actually generic. ARM64 has tagged pointers too. Right now the
> system call interfaces are all supposed to mask off the tags, but
> there's been noise about having the kernel understand them.
> 
> That said:
> 
>> +#ifndef gup_fixup_start_addr
>> +#define gup_fixup_start_addr(start)    (start)
>> +#endif
> 
> I'd rather name this much more specifically (ie make it very much
> about "clean up pointer tags") and I'm also not clear on why sparc64
> actually wants this. I thought the sparc64 rules were the same as the
> (current) arm64 rules: any addresses passed to the kernel have to be
> the non-tagged ones.
> 
> As you say, nothing *else* in the kernel does that address cleanup,
> why should get_user_pages_fast() do it?
> 
> David? Khalid? Why does sparc64 actually need this? It looks like the
> generic get_user_pages() doesn't do it.
> 


There is another discussion going on about tagged pointers on ARM64 and
intersection with sparc64 code. I agree there is a generic need to mask
off tags for kernel use now that ARM64 is also looking into supporting
memory tagging. The need comes from sparc64 not storing tagged address
in VMAs. It is not practical to store tagged addresses in VMAs because
manipulation of address tags is done entirely in userspace on sparc64.
Userspace is free to change tags on an address range at any time without
involving kernel and constantly rotating tags is actually a security
feature even. This makes it impractical for kernel to try to keep up
with constantly changing tagged addresses in VMAs. Untagged addresses in
VMAs means any find_vma() and brethren calls need to be passed an
untagged address.

On sparc64, my intent was to support address tagging for dynamically
allocated data buffers only (malloc, mmap and shm specifically) and not
for any generic system calls which limited the scope and amount of
untagging needed in the kernel. ARM64 is working to add transparent
tagged address support at C library level. Adding tagged addresses to C
library requires every possible call into kernel to either handle tagged
addresses or untag address at some point. Andrey found out it is not as
easy as untagging addresses in functions that search through vma.
Callers of find_vma() and others tend to do address arithmetic on the
address stored in vma that is returned. This requires a more complex
solution than just stripping tags in vma lookup routines.

Since untagging addresses is a generic need required for far more than
gup, I prefer the way Andrey wrote it -
<https://patchwork.kernel.org/patch/10923637/>

--
Khalid
