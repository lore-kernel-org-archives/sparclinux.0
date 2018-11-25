From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sun, 25 Nov 2018 05:28:07 +0000
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
Message-Id: <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
In-Reply-To: <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: willemdebruijn.kernel@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

> > > +       if (type = SO_TIMESTAMP_NEW || type = SO_TIMESTAMPNS_NEW)
> > > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > > +       else
> > > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > > +
> >
> > if adding a boolean whether the socket uses new or old-style
> > timestamps, perhaps fail hard if a process tries to set a new-style
> > option while an old-style is already set and vice versa. Also include
> > SO_TIMESTAMPING_NEW as it toggles the same option.

I do not think this is a problem.
Consider this example, if there is a user application with updated
socket timestamps is linking into a library that is yet to be updated.

Besides, the old timestamps should work perfectly fine on 64 bit
arches even beyond 2038.
So failing here means adding a bunch of ifdef's to verify it is not
executing on 64 bit arch or something like x32.

> > > diff --git a/net/socket.c b/net/socket.c
> > > index d3defba55547..9abeb6bc9cfe 100644
> > > --- a/net/socket.c
> > > +++ b/net/socket.c
> > > @@ -699,6 +699,38 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
> > >                  sizeof(ts_pktinfo), &ts_pktinfo);
> > >  }
> > >
> > > +static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
> > > +                                  struct sk_buff *skb)
> > > +{
> > > +       if (sock_flag(sk, SOCK_TSTAMP_NEW)) {
> > > +               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > > +                       struct sock_timeval tv;
> > > +
> > > +                       skb_get_new_timestamp(skb, &tv);
> > > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
> > > +                                sizeof(tv), &tv);
> > > +               } else {
> > > +                       struct __kernel_timespec ts;
> > > +
> > > +                       skb_get_new_timestampns(skb, &ts);
> > > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
> > > +                                sizeof(ts), &ts);
> > > +               }
> > > +       }
> > > +       if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > > +               struct __kernel_old_timeval tv;
> > > +
> > > +               skb_get_timestamp(skb, &tv);
> > > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
> > > +                        sizeof(tv), &tv);
> > > +       } else {
> > > +               struct timespec ts;
> > > +
> > > +               skb_get_timestampns(skb, &ts);
> > > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> > > +                        sizeof(ts), &ts);
> > > +       }
> > > +}
> > >  /*
> > >   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
> > >   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> > > @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> > >                 false_tstamp = 1;
> > >         }
> > > -       if (need_software_tstamp) {
> >
> > Considerably less code churn if adding __sock_recv_timestamp_2038 and
> > calling that here:
> >
> >                    if (sock_flag(sk, SOCK_TSTAMP_NEW))
> >                            __sock_recv_timestamp_2038(msg, sk, skb);
> >                    else if ...
> >
> > Same for the tcp case above, really, and in the case of the next patch
> > for SO_TIMESTAMPING_NEW
>
> That naming convention, ..._2038, is not the nicest, of course. That
> is not the relevant bit in the above comment.
>
> Come to think of it, and related to my question in patch 2 why the
> need to rename at all, could all new structs, constants and functions
> be named consistently with 64 suffix? __sock_recv_timestamp64,
> SO_TIMESTAMPING64 and timeval64 (instead of sock_timeval,
> it isn't really a sock specific struct)?
>
> I guess that there is a good reason for the renaming exercise and
> conditional mapping of SO_TIMESTAMP onto old or new interface.
> Please elucidate in the commit message.

I think there is some confusion here.

The existing timestamp options: SO_TIMESTAMP* fail to provide proper
timestamps beyond year 2038 on 32 bit ABIs.
But, these work fine on 64 bit native ABIs.
So now we need a way of updating these timestamps so that we do not
break existing userspace: 64 bit ABIs should not have to change
userspace, 32 bit ABIs should work as is until 2038 after which they
have bad timestamps.
So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
assume that 32 bit applications will switch to new ABIs at some point,
but leave the older timestamps as is.
I can update the commit text as per above.

-Deepa
