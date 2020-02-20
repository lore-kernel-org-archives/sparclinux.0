From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 20 Feb 2020 17:41:55 +0000
Subject: Re: [PATCH v2 1/2] sparc,x86: vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
Message-Id: <20200220174155.GA40621@ubuntu-m2-xlarge-x86>
List-Id: <sparclinux.vger.kernel.org>
References: <20200220110807.32534-1-masahiroy@kernel.org>
In-Reply-To: <20200220110807.32534-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, clang-built-linux@googlegroups.com, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, sparclinux@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:08:06PM +0900, Masahiro Yamada wrote:
> The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected
> because <linux/compiler_types.h> is parsed before vclock_gettime.c
> since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
> struct attributes").
> 
> Since then, <linux/compiler_types.h> is included really early by
> using the '-include' option. So, you cannot negate the decision of
> <linux/compiler_types.h> in this way.
> 
> You can confirm it by checking the pre-processed code, like this:
> 
>   $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i
> 
> There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> It is about two years since 28128c61e08e. Nobody has reported a
> problem (or, nobody has even noticed the fact that this code is not
> working).
> 
> It is ugly and unreliable to attempt to undefine a CONFIG option from
> C files, and anyway the inlining heuristic is up to the compiler.
> 
> Just remove the broken code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
