From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 14:38:29 +0000
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
Message-Id: <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de>
 <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
In-Reply-To: <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffrey Walton <noloader@gmail.com>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Adam Borowski <kilobyte@angband.pl>, James Hogan <jhogan@kernel.org>, Will Deacon <will.deacon@arm.com>, Albert ARIBAUD <albert.aribaud@3adev.fr>, Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, tg@mirbsd.de, Catalin Marinas <catalin.marinas@arm.com>, Ben Hutchings <ben@decadent.org.uk>, "H . J . Lu" <hjl.tools@gmail.com>, Daniel Schepler <dschepler@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner <tglx@linutronix.de>, GNU C Library <libc-alpha@sourceware.org>, Linux

On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>> +#if !defined(__x86_64__) || !defined(__ilp32__)
>>  #include <asm-generic/msgbuf.h>
>> +#else
>
> I understand there's some progress having Clang compile the kernel.
> Clang treats __ILP32__ and friends differently than GCC. I believe
> ILP32 shows up just about everywhere there are 32-bit ints, longs and
> pointers. You might find it on Aarch64 or you might find it on MIPS64
> when using Clang.
>
> I think that means this may be a little suspicious:
>
>     > +#if !defined(__x86_64__) || !defined(__ilp32__)
>
> I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
> devs insisted they were within their purview. Also see
> https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.
>
> Sorry about the top-post. I just wanted to pick out that one piece.

It seems I made a typo and it needs to be __ILP32__ rather than
__ilp32__ (corrected that locally, will resend once we have resolved
this).

Aside from that, the #if check seems to be correct to me: this
is an x86-specific header, so it won't ever be seen on other
architectures. On x86-32, __x86_64__ isn't set, so we don't care
about whether __ilp32__ is set or not, and on x86-64 (lp64),
__ilp32__ is never set, so we still get the asm-generic header.

      Arnd
