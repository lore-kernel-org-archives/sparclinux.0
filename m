From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 25 Sep 2019 09:51:19 +0000
Subject: Re: latest git kernel (v5.3-11506-gf7c3bf8fa7e5) does not compile
Message-Id: <CADxRZqxobQN2mxprSQN3jbE7KpYGOMm50+CmtyCpqEbgcVgPFQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
 <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com> <CAK7LNAR3szhzH89ujCPq5Xz8rm0xvSjJdx0TebsaU8yiroXXVg@mail.gmail.com>
In-Reply-To: <CAK7LNAR3szhzH89ujCPq5Xz8rm0xvSjJdx0TebsaU8yiroXXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>, "David S. Miller" <davem@davemloft.net>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Sun, Sep 22, 2019 at 2:38 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Sun, Sep 22, 2019 at 5:33 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> > On Sun, Sep 22, 2019 at 11:13 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> > >
> > > Hello!
> > >
> > > Latest git kernel does not compile for me:
> > >
> > > ~/linux-2.6$ git desc
> > > v5.3-11506-gf7c3bf8fa7e5
> > >
> > > ~/linux-2.6$ make
> > >   CALL    scripts/checksyscalls.sh
> > > <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   CHK     include/generated/compile.h
> > >   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> > > unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> > > arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> > > make[2]: *** [scripts/Makefile.build:266:
> > > arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
> > > make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
> > > make[1]: *** [scripts/Makefile.build:509: arch/sparc/vdso] Error 2
> > > make: *** [Makefile:1667: arch/sparc] Error
> > >
> > > but I was able to compile successfully v5.3-10169-g574cc4539762
>
>
> Thanks for the report, and apology for the breakage.
>
> Please check this patch.
> https://lore.kernel.org/patchwork/patch/1130469/
>
> I hope it will fix the build error.

Masahiro,

fixes kernel compilation for me, thanks!

David,

can we please push it to current git kernel , so later bisect sessions
does not need yet another patch... Thanks.

Tested-by: Anatoly Pugachev <matorola@gmail.com>
