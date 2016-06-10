From: Jason Baron <jbaron@akamai.com>
Date: Fri, 10 Jun 2016 21:28:40 +0000
Subject: Re: [PATCH v2 4/4] dynamic_debug: add jump label support
Message-Id: <575B3108.1020409@akamai.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1463778029.git.jbaron@akamai.com>
 <587263b37406eda0d2ab84874a9fd4c81eaeca1d.1463778029.git.jbaron@akamai.com>
 <3796097.4dlb9d7Id8@wuerfel>
In-Reply-To: <3796097.4dlb9d7Id8@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: akpm@linux-foundation.org, joe@perches.com, peterz@infradead.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, cmetcalf@mellanox.com

On 06/10/2016 05:54 AM, Arnd Bergmann wrote:
> On Friday, May 20, 2016 5:16:36 PM CEST Jason Baron wrote:
>> Although dynamic debug is often only used for debug builds, sometimes its
>> enabled for production builds as well. Minimize its impact by using jump
>> labels. This reduces the text section by 7000+ bytes in the kernel image
>> below. It does increase data, but this should only be referenced when
>> changing the direction of the branches, and hence usually not in cache.
>>
>>    text	   data	    bss	    dec	    hex	filename
>> 8194852	4879776	 925696	14000324	 d5a0c4	vmlinux.pre
>> 8187337	4960224	 925696	14073257	 d6bda9	vmlinux.post
>>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> ---
> 
> This causes problems for some of my randconfig builds, when a dynamic
> debug call is used inside of an __exit function:
> 
> `.exit.text' referenced in section `__jump_table' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> `.exit.text' referenced in section `__jump_table' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
> 
> 	Arnd
> 

Hi Arnd,

Ok, I managed to reproduce this on tile and sparc64 by adding
static_branch_[un]likely() to __exit functions as you mentioned.
Although I didn't find the actual broken config.

I think its only an issue on those 2 arches b/c they have jump
label support and discard __exit text at build time (most
arches seem to do it at run-time). Thus, we can end up with
references in the __jump_table to addresses that may be in an
__exit section. The jump label code already protects itself
from touch code in the init sections after it has been freed.
Thus, simply having functions marked with __exit in the init
section is sufficient here.

I tried the following patches on tile and sparc and they
at least now compile. If anybody has real h/w that would
be helpful :)

Thanks,

-Jason

--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -151,6 +151,12 @@ SECTIONS
        PERCPU_SECTION(SMP_CACHE_BYTES)

        . = ALIGN(PAGE_SIZE);
+       .exit.text : {
+               EXIT_TEXT
+       }
+
+       . = ALIGN(PAGE_SIZE);
+
        __init_end = .;
        BSS_SECTION(0, 0, 0)
        _end = . ;

--- a/arch/tile/kernel/vmlinux.lds.S
+++ b/arch/tile/kernel/vmlinux.lds.S
@@ -58,7 +58,21 @@ SECTIONS
   _etext = .;

   /* "Init" is divided into two areas with very different virtual
addresses. */
+  . = ALIGN(PAGE_SIZE);
+  .init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
+     __init_begin = .; /* paired with __init_end */
+  }
+
   INIT_TEXT_SECTION(PAGE_SIZE)
+  .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
+       EXIT_TEXT
+  }
+
+  . = ALIGN(PAGE_SIZE);
+  /* freed after init ends here */
+  .init.end : AT(ADDR(.init.end) - LOAD_OFFSET) {
+       __init_end = .;
+  }

   /* Now we skip back to PAGE_OFFSET for the data. */
   . = (. - TEXT_OFFSET + PAGE_OFFSET);

