From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Jul 2016 04:18:19 +0000
Subject: Re: [RFC/PATCH 00/14] split exception table content out of module.h into extable.h
Message-Id: <CA+55aFyDw_jK609LcjpWvVMTzCWuH6nLUXiZDeYC2tpSaZqhXA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>Rus

On Sun, Jul 24, 2016 at 8:42 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> While doing an audit looking for unnecessary instances of module.h
> inclusion across arch/x86/ I found a significant number of includes
> of module.h were for things like search_exception_table and friends.
>
> For historical reasons (i.e. pre-git) the exception table stuff was
> buried in the middle of the module.h file.  So we have core kernel
> files that are completely non-modular (both arch specific and arch
> independent) that are just including module.h for this.
>
> The converse is also true, in that conventional drivers, be they for
> filesystems or actual hardware peripherals or similar, do not
> normally care about the exception tables.
>
> Here we fork the exception table content [...]

This looks to be the right thing to do as far as I can tell. I'm not
sure how big of a problem the extable stuff is (we definitely have
much bigger unnecessary include files that cause a lot more problems),
but it seems like a reasonable cleanup.

              Linus
