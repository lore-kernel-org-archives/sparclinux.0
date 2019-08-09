From: Anatoly Pugachev <matorola@gmail.com>
Date: Fri, 09 Aug 2019 19:59:23 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <CADxRZqy61-JOYSv3xtdeW_wTDqKovqDg2G+a-=LH3w=mrf2zUQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org>
In-Reply-To: <20190717215956.GA30369@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Christoph Hellwig <hch@lst.de>, Khalid Aziz <khalid.aziz@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Thu, Jul 18, 2019 at 12:59 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Tue, Jun 25, 2019 at 04:37:08PM +0200, Christoph Hellwig wrote:
> > The sparc64 code is mostly equivalent to the generic one, minus various
> > bugfixes and two arch overrides that this patch adds to pgtable.h.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > ---
> >  arch/sparc/Kconfig                  |   1 +
> >  arch/sparc/include/asm/pgtable_64.h |  18 ++
> >  arch/sparc/mm/Makefile              |   2 +-
> >  arch/sparc/mm/gup.c                 | 340 ----------------------------
> >  4 files changed, 20 insertions(+), 341 deletions(-)
> >  delete mode 100644 arch/sparc/mm/gup.c
>
> So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505

I've tried to revert this commit on a current master branch , but i'm getting :

linux-2.6$ git show 7b9afb86b632 > /tmp/gup.patch
linux-2.6$ patch -p1 -R < /tmp/gup.patch
...
linux-2.6$ make -j && make -j modules
...
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CHK     include/generated/compile.h
  CHK     include/generated/autoksyms.h
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
ld: mm/gup.o: in function `__get_user_pages_fast':
gup.c:(.text+0x1bc0): multiple definition of `__get_user_pages_fast';
arch/sparc/mm/gup.o:gup.c:(.text+0x620): first defined here
ld: mm/gup.o: in function `get_user_pages_fast':
gup.c:(.text+0x1be0): multiple definition of `get_user_pages_fast';
arch/sparc/mm/gup.o:gup.c:(.text+0x740): first defined here
make: *** [Makefile:1060: vmlinux] Error 1

Can someone help me to revert this commit? Is it even possible? Since
it's not only futex strace calls getting killed and producing OOPS,
even util-linux.git 'make check' hangs machine/LDOM with multiple OOPS
in logs, while previous (before this commit) kernel passes tests ok
(and without kernel OOPS). I've already tried to compile current
master with gcc-6, gcc-7, gcc-8 debian versions, but all produce same
OOPS.

Thanks.
