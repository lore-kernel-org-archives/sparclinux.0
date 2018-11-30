From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 30 Nov 2018 23:37:34 +0000
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
Message-Id: <CAF=yD-J=yTunQr279x8qb5B0xdAcdmcBj6utyM1gE8QfgorQPw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
 <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
 <CAF=yD-LngkYq23Q2TCJv_0PRiAryznYRWRbqYFaQkNO=U0w9gQ@mail.gmail.com> <CABeXuvp5OaVetzJJf2L5ZE1BP_KOO2FvvG8EWn5t29eCe-=dtg@mail.gmail.com>
In-Reply-To: <CABeXuvp5OaVetzJJf2L5ZE1BP_KOO2FvvG8EWn5t29eCe-=dtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Nov 30, 2018 at 5:43 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Sun, Nov 25, 2018 at 6:33 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Sun, Nov 25, 2018 at 12:28 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > > > > +       if (type = SO_TIMESTAMP_NEW || type = SO_TIMESTAMPNS_NEW)
> > > > > > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > > > > > +       else
> > > > > > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > > > > > +
> > > > >
> > > > > if adding a boolean whether the socket uses new or old-style
> > > > > timestamps, perhaps fail hard if a process tries to set a new-style
> > > > > option while an old-style is already set and vice versa. Also include
> > > > > SO_TIMESTAMPING_NEW as it toggles the same option.
> > >
> > > I do not think this is a problem.
> > > Consider this example, if there is a user application with updated
> > > socket timestamps is linking into a library that is yet to be updated.
> >
> > Also consider applications that do not use libraries.
>
> Arnd and I talked about this.
> We thought that the new options should behave like the already
> existing options. The patch already does this.
> Eg: Today if we set SO_TIMESTAMP and then try to switch to
> SO_TIMESTAMPNS then there is no fail.

> Do you still want a hard fail?

I do think that it is preferable. In general, and in this specific case.

We have had had many bug reports from syzkaller where the fuzzer
manages to trigger unexpected behavior by combining two APIs
that were never intended to be used together.

However inane the combination may be, once an API is published,
we cannot simply add an EINVAL and stop supporting it. So it is safer
to explicitly block unsafe combinations from the start. If there is a
legitimate use it is always possible to loosen that restriction later.

I don't see any sensible use for mixing both the old and the new
interface on the same socket.

That said, just a suggestion.
