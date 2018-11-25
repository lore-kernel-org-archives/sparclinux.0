From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sun, 25 Nov 2018 05:55:50 +0000
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
Message-Id: <CABeXuvr6fi9UPwMvuafx7MwEta-Sx1TLNN0KQ8HQHhn=vAne5Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com> <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
In-Reply-To: <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: willemdebruijn.kernel@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

A couple of comments I missed:

> > > >  /*
> > > >   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
> > > >   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> > > > @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> > > >                 false_tstamp = 1;
> > > >         }
> > > > -       if (need_software_tstamp) {
> > >
> > > Considerably less code churn if adding __sock_recv_timestamp_2038 and
> > > calling that here:
> > >
> > >                    if (sock_flag(sk, SOCK_TSTAMP_NEW))
> > >                            __sock_recv_timestamp_2038(msg, sk, skb);
> > >                    else if ...
> > >
> > > Same for the tcp case above, really, and in the case of the next patch
> > > for SO_TIMESTAMPING_NEW
> >
> > That naming convention, ..._2038, is not the nicest, of course. That
> > is not the relevant bit in the above comment.

it could be  __sock_recv_timestamp64().
But, these timestamps should be doing exactly the same thing as the
old ones and I thought it would be nicer to keep the same code path.
I can change it to as per above.

> > Come to think of it, and related to my question in patch 2 why the
> > need to rename at all, could all new structs, constants and functions
> > be named consistently with 64 suffix? __sock_recv_timestamp64,
> > SO_TIMESTAMPING64 and timeval64 (instead of sock_timeval,
> > it isn't really a sock specific struct)?
> >
> > I guess that there is a good reason for the renaming exercise and
> > conditional mapping of SO_TIMESTAMP onto old or new interface.
> > Please elucidate in the commit message.
>
> I think there is some confusion here.
>
> The existing timestamp options: SO_TIMESTAMP* fail to provide proper
> timestamps beyond year 2038 on 32 bit ABIs.
> But, these work fine on 64 bit native ABIs.
> So now we need a way of updating these timestamps so that we do not
> break existing userspace: 64 bit ABIs should not have to change
> userspace, 32 bit ABIs should work as is until 2038 after which they
> have bad timestamps.
> So we introduce new y2038 safe timestamp options for 32 bit ABIs. We
> assume that 32 bit applications will switch to new ABIs at some point,
> but leave the older timestamps as is.
> I can update the commit text as per above.

We have been avoiding adding timeval64 timestamps to discourage users
from using these types in the interfaces.
We want to keep all the uapi time interfaces to use __kernel_*
interfaces. And, we already provide __kernel_timespec interface for
such instances.
But, in this case we do not have an option. So we introduce a type
specific to sockets.

-Deepa
