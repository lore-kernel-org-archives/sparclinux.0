From: Chris Metcalf <cmetcalf@mellanox.com>
Date: Wed, 06 Jul 2016 16:52:23 +0000
Subject: Re: [PATCH v2 4/4] dynamic_debug: add jump label support
Message-Id: <b0cc5899-ce56-bb26-38e8-c3e2528da961@mellanox.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1463778029.git.jbaron@akamai.com>
 <587263b37406eda0d2ab84874a9fd4c81eaeca1d.1463778029.git.jbaron@akamai.com>
 <3796097.4dlb9d7Id8@wuerfel> <575B3108.1020409@akamai.com>
 <5c98fce0-7d90-14ec-6ff5-6fd5cde673b8@mellanox.com>
 <577C1F43.9090209@akamai.com>
In-Reply-To: <577C1F43.9090209@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Baron <jbaron@akamai.com>, Arnd Bergmann <arnd@arndb.de>
Cc: akpm@linux-foundation.org, joe@perches.com, peterz@infradead.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On 7/5/2016 4:57 PM, Jason Baron wrote:
> On 07/01/2016 03:30 PM, Chris Metcalf wrote:
>> On 6/10/2016 5:28 PM, Jason Baron wrote:
>>> Hi Arnd,
>>>
>>> Ok, I managed to reproduce this on tile and sparc64 by adding
>>> static_branch_[un]likely() to __exit functions as you mentioned.
>>> Although I didn't find the actual broken config.
>>>
>>> I think its only an issue on those 2 arches b/c they have jump
>>> label support and discard __exit text at build time (most
>>> arches seem to do it at run-time). Thus, we can end up with
>>> references in the __jump_table to addresses that may be in an
>>> __exit section. The jump label code already protects itself
>>> from touch code in the init sections after it has been freed.
>>> Thus, simply having functions marked with __exit in the init
>>> section is sufficient here.
>> How does this patch work instead?
>>
>> diff --git a/arch/tile/kernel/vmlinux.lds.S
>> b/arch/tile/kernel/vmlinux.lds.S
>> index 378f5d8d1ec8..5e83d2689def 100644
>> --- a/arch/tile/kernel/vmlinux.lds.S
>> +++ b/arch/tile/kernel/vmlinux.lds.S
>> @@ -58,7 +58,15 @@ SECTIONS
>>     _etext = .;
>>
>>     /* "Init" is divided into two areas with very different virtual
>> addresses. */
>> -  INIT_TEXT_SECTION(PAGE_SIZE)
>> +  . = ALIGN(PAGE_SIZE);
>> +  .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
>> +    VMLINUX_SYMBOL(_sinittext) = .;
>> +    INIT_TEXT
>> +#ifdef CONFIG_JUMP_LABEL  /* __jump_table may reference __exit text */
>> +    EXIT_TEXT
>> +#endif
>> +    VMLINUX_SYMBOL(_einittext) = .;
>> +  }
>>
>>     /* Now we skip back to PAGE_OFFSET for the data. */
>>     . = (. - TEXT_OFFSET + PAGE_OFFSET);
>>
>
> Hi Chris,
>
> Thanks for the patch. I can confirm that it resolves the following
> compilation issue:
>
> `.exit.text' referenced in section `__jump_table' of fs/built-in.o:
> defined in discarded section `.exit.text' of fs/built-in.o
> `.exit.text' referenced in section `__jump_table' of fs/built-in.o:
> defined in discarded section `.exit.text' of fs/built-in.o
>
> I was able to create the issue by simply adding a
> static_key_unlikely() branch to an __exit section that ends
> up being built-in (non-module).
>
> So this issue is really independent of this patch series...
> Should I add your patch to my series when I re-post?

I'm happy to just take a version of this into the tile tree instead, since
you're right, it's a pre-existing problem.  I'll post the revised change
shortly and cc you.  Thanks!

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

