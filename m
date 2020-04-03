From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 03 Apr 2020 05:57:20 +0000
Subject: Re: [PATCH v2 1/2] sparc,x86: vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
Message-Id: <CAK7LNAQuOF-DcA7v3Uy-7hdVeT5hDuatGg6FY9TgG10T3OBr0w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200220110807.32534-1-masahiroy@kernel.org> <CAK7LNARHBfp=gkVO9q3pC9o_w9PgNW=5AP95s1MR1tHLJV=0fg@mail.gmail.com>
In-Reply-To: <CAK7LNARHBfp=gkVO9q3pC9o_w9PgNW=5AP95s1MR1tHLJV=0fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, sparclinux <sparclinux@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 19, 2020 at 4:20 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Andrew,
>
> Ping.
> Could you pick up this series?
>
>
> Thanks.
>
>
> On Thu, Feb 20, 2020 at 8:08 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected
> > because <linux/compiler_types.h> is parsed before vclock_gettime.c
> > since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
> > struct attributes").
> >
> > Since then, <linux/compiler_types.h> is included really early by
> > using the '-include' option. So, you cannot negate the decision of
> > <linux/compiler_types.h> in this way.
> >
> > You can confirm it by checking the pre-processed code, like this:
> >
> >   $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i
> >
> > There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.
> >
> > It is about two years since 28128c61e08e. Nobody has reported a
> > problem (or, nobody has even noticed the fact that this code is not
> > working).
> >
> > It is ugly and unreliable to attempt to undefine a CONFIG option from
> > C files, and anyway the inlining heuristic is up to the compiler.
> >
> > Just remove the broken code.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>



I think adding the patch author to Cc:
is strange.



The footer of 6290b47e9aa282c11f38390931b06402c553dbc4
looks like this.


    Link: http://lkml.kernel.org/r/20200220110807.32534-1-masahiroy@kernel.org
    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Masahiro Yamada <masahiroy@kernel.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: "H. Peter Anvin" <hpa@zytor.com>
    Cc: David Miller <davem@davemloft.net>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>



"Cc: Masahiro Yamada <masahiroy@kernel.org>"
is unneeded since I am the author.



-- 
Best Regards
Masahiro Yamada
