From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sat, 15 Dec 2018 16:50:58 +0000
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
Message-Id: <CABeXuvqrZgEDF5RYQEPJ8RyXDg0uvXx_qMq=2ER8Bc9RXFPDGQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
 <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com> <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
In-Reply-To: <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: willemdebruijn.kernel@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

On Sat, Dec 15, 2018 at 7:12 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Dec 14, 2018 at 8:07 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > > > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > > > index 00e45c80e574..352e3dc0b3d9 100644
> > > > --- a/arch/alpha/include/uapi/asm/socket.h
> > > > +++ b/arch/alpha/include/uapi/asm/socket.h
> > > > @@ -3,6 +3,7 @@
> > > >  #define _UAPI_ASM_SOCKET_H
> > > >
> > > >  #include <asm/sockios.h>
> > > > +#include <asm/bitsperlong.h>
> > > >
> > > >  /* For setsockopt(2) */
> > > >  /*
> > > > @@ -110,12 +111,22 @@
> > > >
> > > >  #define SO_TIMESTAMP_OLD         29
> > > >  #define SO_TIMESTAMPNS_OLD       35
> > > > +
> > > >  #define SO_TIMESTAMPING_OLD      37
> > > >
> > > > +#define SO_TIMESTAMP_NEW         62
> > > > +#define SO_TIMESTAMPNS_NEW       63
> > > > +
> > > >  #if !defined(__KERNEL__)
> > > >
> > > > -#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > > > -#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > > > +#if __BITS_PER_LONG = 64
> > > > +#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > > > +#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > > > +#else
> > > > +#define SO_TIMESTAMP (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
> > > > +#define SO_TIMESTAMPNS (sizeof(time_t) = sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
> > > > +#endif
> > > > +
> > >
> > > This is not platform specific. Perhaps it can be deduplicated. The
> > > interface expects callers to include <linux/socket.h>, not
> > > <asm/socket.h> directly. So perhaps it can go there?
> >
> > I'm not following what you are saying here.
> >
> > Are you talking about in kernel users or userspace interface?
> >
> > Userspace should always include sys/socket.h according to the man page.
> > I'm not sure if userspace can even include linux/socket.h directly.
> > On my distribution this includes bits/socket.h which in turn includes
> > asm/socket.h.
>
> I meant include/uapi/linux/socket.h.
>
> But you're right that that is not referenced from sys/socket.h.
>
> I do see a reference to it in my bits/socket.h
>
>     /* Socket level message types.  This must match the definitions in
>        <linux/socket.h>.  */
>
> so perhaps the logic could be both there and in libc bits/socket.h.

bits/socket.h cannot be included directly, and it's just how one of
the libc implementations decided to do it.
It doesn't even have to exist.

> > Which file gets installed as asm/socket.h is defined per architecture
> > in the kbuild file such as
> > arch/ia64/include/uapi/asm/Kbuild (without series applied):
> >
> >  generic-y += poll.h
> >  generic-y += sembuf.h
> >  generic-y += shmbuf.h
> >  generic-y += socket.h
> >
> > Also the new timestamp numbers being added are not the same for all
> > architectures.
> >
> > So I'm not sure how this can be moved to linux/socket.h.
>
> Does that matter, as long as they are defined? This basic block is the
> same between all archs:

3 reasons for not doing this:

1. We do not want to break userspace. If we move this to
linux/socket.h all the userspace programs now have to include
linux/socket.h or get this definition through a new libc.
2. All the socket options are together in the file asm/socket.h. It
doesn't seem good for maintainability to move just a few bits
elsewhere.
3. There are only 4 arches (after the series is applied) that have
their own asm/socket.h. And, this is because there seems to be
significant differences to asm-generic/socket.h that don't seem
logically obvious to group and eliminate some of the defines.

Also for the other comment. The reason the conditionals were not
consistent is because they were not consistent to begin with.
I'm trying to follow your request to keep code churn to minimal.
It's just that I moved to a different function as that seemed logical
to me. Do you prefer me to remove that refactoring?

-Deepa
