From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2013 08:05:19 +0000
Subject: Re: [PATCH -next] sparc32/sparc64: Provide cmpxchg64()
Message-Id: <CAMuHMdXHuT16xuw3-5rwL2WY7ZRzfweB7jKVyoi-xnqT4B0pBg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1363290128-21247-1-git-send-email-geert@linux-m68k.org>
	<20130319.162000.1936616024625986095.davem@davemloft.net>
In-Reply-To: <20130319.162000.1936616024625986095.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org

Hi David,

On Tue, Mar 19, 2013 at 9:20 PM, David Miller <davem@davemloft.net> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Date: Thu, 14 Mar 2013 20:42:08 +0100
>
>> sparc/sparc64 allmodconfig:
>>
>> drivers/block/blockconsole.c: In function ‘bcon_advance_console_bytes’:
>> drivers/block/blockconsole.c:164: error: implicit declaration of function
>> ‘cmpxchg64’
>>
>> Map cmpxchg64 to cmpxchg64_local to fix this.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> But, in the sparc 32-bit case, the _local() variants are only atomic
> from the perspective of the current cpu, they are not globally atomic.
>
> This is true because the sparc 32-bit cases use the
> asm-generic/cmpxchg-local.h helpers.
>
> I really can't apply this, it isn't correct, sorry.

You're right, sorry for that.

The sparc64 part is still OK as it eventually calls __cmpxchg_u64(), isn't it?

Do you want me to send a new patch for that part only, or will you just
remove the sparc32 part?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
