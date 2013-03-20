From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2013 14:35:17 +0000
Subject: Re: [PATCH -next] sparc32/sparc64: Provide cmpxchg64()
Message-Id: <CAMuHMdUuOeh3YK1XcveB_5OoNKHLHzyNOgF8mysicSnkfMa7_Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1363290128-21247-1-git-send-email-geert@linux-m68k.org>
	<20130319.162000.1936616024625986095.davem@davemloft.net>
	<CAMuHMdXHuT16xuw3-5rwL2WY7ZRzfweB7jKVyoi-xnqT4B0pBg@mail.gmail.com>
	<20130320.101102.2237935685619866372.davem@davemloft.net>
In-Reply-To: <20130320.101102.2237935685619866372.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org

On Wed, Mar 20, 2013 at 3:11 PM, David Miller <davem@davemloft.net> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Date: Wed, 20 Mar 2013 09:05:19 +0100
>
>> The sparc64 part is still OK as it eventually calls __cmpxchg_u64(),
>> isn't it?
>
> Yes, that part is OK.
>
>> Do you want me to send a new patch for that part only, or will you just
>> remove the sparc32 part?
>
> Please send a new patch, thank you.

OK, done.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
