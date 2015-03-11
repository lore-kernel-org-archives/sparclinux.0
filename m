From: Kees Cook <keescook@chromium.org>
Date: Wed, 11 Mar 2015 18:59:55 +0000
Subject: Re: [PATCH v3 0/8] switch to using asm-generic for seccomp.h
Message-Id: <CAGXu5j+PMBEPLTLiDVZ9XvnT9a2P+tOGPLXfE865crteeChDFQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-m>

On Wed, Mar 4, 2015 at 5:27 PM, Kees Cook <keescook@chromium.org> wrote:
> Most architectures don't need to do much special for the strict-mode
> seccomp syscall entries. Remove the redundant headers and reduce the
> others.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Andrew,

Just a quick ping: are you able to pick up this series, or should I
try to get this in on a per-arch basis?

Thanks!

-Kees

> ---
> v3:
> - split patch series by architecture
> - fix up architectures that need sigreturn overrides (ingo)
> v2:
> - use Kbuild "generic-y" instead of explicit #include lines (sfr)
>



-- 
Kees Cook
Chrome OS Security
