From: Nathan Chancellor <natechancellor@gmail.com>
Date: Sat, 13 Jul 2019 06:07:41 +0000
Subject: Re: [PATCH] kbuild: add --hash-style= and --build-id unconditionally
Message-Id: <20190713060741.GA76046@archlinux-threadripper>
List-Id: <sparclinux.vger.kernel.org>
References: <20190713040110.18210-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190713040110.18210-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On Sat, Jul 13, 2019 at 01:01:10PM +0900, Masahiro Yamada wrote:
> As commit 1e0221374e30 ("mips: vdso: drop unnecessary cc-ldoption")
> explained, these flags are supported by the minimal required version
> of binutils.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Also supported by ld.lld; I tested both arm and x86, the build ID shows
up fine.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
