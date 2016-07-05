From: Jason Baron <jbaron@akamai.com>
Date: Tue, 05 Jul 2016 20:57:39 +0000
Subject: Re: [PATCH v2 4/4] dynamic_debug: add jump label support
Message-Id: <577C1F43.9090209@akamai.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1463778029.git.jbaron@akamai.com>
 <587263b37406eda0d2ab84874a9fd4c81eaeca1d.1463778029.git.jbaron@akamai.com>
 <3796097.4dlb9d7Id8@wuerfel> <575B3108.1020409@akamai.com>
 <5c98fce0-7d90-14ec-6ff5-6fd5cde673b8@mellanox.com>
In-Reply-To: <5c98fce0-7d90-14ec-6ff5-6fd5cde673b8@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Metcalf <cmetcalf@mellanox.com>, Arnd Bergmann <arnd@arndb.de>
Cc: akpm@linux-foundation.org, joe@perches.com, peterz@infradead.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On 07/01/2016 03:30 PM, Chris Metcalf wrote:
> On 6/10/2016 5:28 PM, Jason Baron wrote:
>> On 06/10/2016 05:54 AM, Arnd Bergmann wrote:
>>> On Friday, May 20, 2016 5:16:36 PM CEST Jason Baron wrote:
>>>> Although dynamic debug is often only used for debug builds,
>>>> sometimes its
>>>> enabled for production builds as well. Minimize its impact by using
>>>> jump
>>>> labels. This reduces the text section by 7000+ bytes in the kernel
>>>> image
>>>> below. It does increase data, but this should only be referenced when
>>>> changing the direction of the branches, and hence usually not in cache.
>>>>
>>>>     text       data        bss        dec        hex    filename
>>>> 8194852    4879776     925696    14000324     d5a0c4    vmlinux.pre
>>>> 8187337    4960224     925696    14073257     d6bda9    vmlinux.post
>>>>
>>>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>>>> ---
>>> This causes problems for some of my randconfig builds, when a dynamic
>>> debug call is used inside of an __exit function:
>>>
>>> `.exit.text' referenced in section `__jump_table' of
>>> drivers/built-in.o: defined in discarded section `.exit.text' of
>>> drivers/built-in.o
>>> `.exit.text' referenced in section `__jump_table' of
>>> drivers/built-in.o: defined in discarded section `.exit.text' of
>>> drivers/built-in.o
>>>
>>>     Arnd
>>>
>> Hi Arnd,
>>
>> Ok, I managed to reproduce this on tile and sparc64 by adding
>> static_branch_[un]likely() to __exit functions as you mentioned.
>> Although I didn't find the actual broken config.
>>
>> I think its only an issue on those 2 arches b/c they have jump
>> label support and discard __exit text at build time (most
>> arches seem to do it at run-time). Thus, we can end up with
>> references in the __jump_table to addresses that may be in an
>> __exit section. The jump label code already protects itself
>> from touch code in the init sections after it has been freed.
>> Thus, simply having functions marked with __exit in the init
>> section is sufficient here.
> 
> It seems plausible to me to only include the exit text in with the init
> text
> under an #ifdef CONFIG_JUMP_TABLE (with a suitable comment) in any
> case, because if we don't need to include it in the image, then why do so?
> It adds about 7KB to the loaded size of the vmlinux image for no gain
> (on a typical tilegx configuration).
> 
>> --- a/arch/tile/kernel/vmlinux.lds.S
>> +++ b/arch/tile/kernel/vmlinux.lds.S
>> @@ -58,7 +58,21 @@ SECTIONS
>>     _etext = .;
>>
>>     /* "Init" is divided into two areas with very different virtual
>> addresses. */
>> +  . = ALIGN(PAGE_SIZE);
>> +  .init.begin : AT(ADDR(.init.begin) - LOAD_OFFSET) {
>> +     __init_begin = .; /* paired with __init_end */
>> +  }
>> +
>>     INIT_TEXT_SECTION(PAGE_SIZE)
>> +  .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
>> +       EXIT_TEXT
>> +  }
>> +
>> +  . = ALIGN(PAGE_SIZE);
>> +  /* freed after init ends here */
>> +  .init.end : AT(ADDR(.init.end) - LOAD_OFFSET) {
>> +       __init_end = .;
>> +  }
>>
>>     /* Now we skip back to PAGE_OFFSET for the data. */
>>     . = (. - TEXT_OFFSET + PAGE_OFFSET);
> 
> This doesn't look right to me; we already have an __init_begin
> symbol defined a few lines further down in vmlinux.lds.S.
> How does this patch work instead?
> 
> diff --git a/arch/tile/kernel/vmlinux.lds.S
> b/arch/tile/kernel/vmlinux.lds.S
> index 378f5d8d1ec8..5e83d2689def 100644
> --- a/arch/tile/kernel/vmlinux.lds.S
> +++ b/arch/tile/kernel/vmlinux.lds.S
> @@ -58,7 +58,15 @@ SECTIONS
>    _etext = .;
> 
>    /* "Init" is divided into two areas with very different virtual
> addresses. */
> -  INIT_TEXT_SECTION(PAGE_SIZE)
> +  . = ALIGN(PAGE_SIZE);
> +  .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
> +    VMLINUX_SYMBOL(_sinittext) = .;
> +    INIT_TEXT
> +#ifdef CONFIG_JUMP_LABEL  /* __jump_table may reference __exit text */
> +    EXIT_TEXT
> +#endif
> +    VMLINUX_SYMBOL(_einittext) = .;
> +  }
> 
>    /* Now we skip back to PAGE_OFFSET for the data. */
>    . = (. - TEXT_OFFSET + PAGE_OFFSET);
> 


Hi Chris,

Thanks for the patch. I can confirm that it resolves the following
compilation issue:

`.exit.text' referenced in section `__jump_table' of fs/built-in.o:
defined in discarded section `.exit.text' of fs/built-in.o
`.exit.text' referenced in section `__jump_table' of fs/built-in.o:
defined in discarded section `.exit.text' of fs/built-in.o

I was able to create the issue by simply adding a
static_key_unlikely() branch to an __exit section that ends
up being built-in (non-module).

So this issue is really independent of this patch series...
Should I add your patch to my series when I re-post?

Thanks,

-Jason
