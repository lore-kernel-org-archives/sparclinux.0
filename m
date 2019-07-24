From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 24 Jul 2019 19:32:17 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org> <20190718.141405.1070121094691581998.davem@davemloft.net>
In-Reply-To: <20190718.141405.1070121094691581998.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, Christoph Hellwig <hch@lst.de>, khalid.aziz@oracle.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Fri, Jul 19, 2019 at 12:14 AM David Miller <davem@davemloft.net> wrote:
> > So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> > (thanks to Anatoly for bisecting) and introduced a regression:
> > futex.test from the strace test suite now causes an Oops on sparc64
> > in futex syscall.
> >
> > Here is a heavily stripped down reproducer:
>
> Does not reproduce for me on a T4-2 machine.
>
> So this problem might depend on the type of system you are on,
> I suspect it's one of those "pre-Niagara vs. Niagara and later"
> situations because that's the dividing line between two set of
> wildly different TLB and cache management methods.
>
> What kind of machine are you on?

David,

the first test where it was discovered was done on my test LDOM named
ttip, hardware (hypervisor) is T5-2 server, running under Solaris 11.4
OS.
ttip LDOM is debian sparc64 unstable , so with almost all the latest
software (gcc 8.3.0, binutils 2.32.51.20190707-1, debian GLIBC
2.28-10, etc..)

For another test, i also installed LDOM with oracle sparc linux
https://oss.oracle.com/projects/linux-sparc/ , but I've to install a
more fresh version of gcc on it first, since system installed gcc 4.4
is too old for a git kernel (linux-2.6/Documentation/Changes lists gcc
4.6 as a minimal version), so I choose to install gcc-7.4.0 to /opt/
(leaving system installed gcc 4.4 under /usr/bin). Compiled and
installed git kernel version, i.e. last tag 5.3.0-rc1 and ran the
test. Kernel still produced oops.
