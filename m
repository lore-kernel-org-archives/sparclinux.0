From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 08 Nov 2020 19:07:44 +0000
Subject: Re: [PATCH 00/19] Add generic user_landing tracking
Message-Id: <CALCETrW-hHyh3nF3ATmy61PCy1iFqVhVYX+-ptBCMP5Bf7aJ0w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201108051730.2042693-1-dima@arista.com>
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Safonov <dima@arista.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, X86 ML <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, "open list:MIPS" <linux-mips@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, LKML <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Sat, Nov 7, 2020 at 9:17 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Started from discussion [1], where was noted that currently a couple of
> architectures support mremap() for vdso/sigpage, but not munmap().
> If an application maps something on the ex-place of vdso/sigpage,
> later after processing signal it will land there (good luck!)
>
> Patches set is based on linux-next (next-20201106) and it depends on
> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
> on my changes in akpm (fixing several mremap() issues).
>
> Logically, the patches set divides on:
> - patch       1: cleanup for patches in x86/cleanups
> - patches  2-11: cleanups for arch_setup_additional_pages()

I like these cleanups, although I think you should stop using terms
like "new-born".  A task being exec'd is not newborn at all -- it's in
the middle of a transformation.

--Andy
