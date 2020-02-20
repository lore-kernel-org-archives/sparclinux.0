From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 20 Feb 2020 09:26:04 +0000
Subject: Re: [PATCH 2/2] compiler: Remove CONFIG_OPTIMIZE_INLINING entirely
Message-Id: <CANiq72nWs3c2MWGTsG=zvDQ21B_=_Yaw3AhRhHDBAr2xFJwF_g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200220071140.14080-1-masahiroy@kernel.org> <20200220071140.14080-2-masahiroy@kernel.org>
In-Reply-To: <20200220071140.14080-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, sparclinux@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Feb 20, 2020 at 8:12 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly") made this always-on option. We released v5.4 and v5.5
> including that commit.
>
> Remove the CONFIG option and clean up the code now.

Yes, please!

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
