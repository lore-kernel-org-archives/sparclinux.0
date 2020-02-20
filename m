From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 20 Feb 2020 09:28:30 +0000
Subject: Re: [PATCH 1/2] vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
Message-Id: <CANiq72kqxdGrZO7NokY6Zkh=e8owBVJCpK5DxWLnwiuxyzCybg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200220071140.14080-1-masahiroy@kernel.org>
In-Reply-To: <20200220071140.14080-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, sparclinux@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Feb 20, 2020 at 8:12 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> It it about two years since 28128c61e08e. Nobody has reported a

Nit: "It it" -> "it is"

> It is ugly and unreliable to attempt to undefine a CONFIG option from
> C files, and anyway the inlining heuristic is up to the compiler.

+1

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
