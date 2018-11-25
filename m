From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 25 Nov 2018 14:33:07 +0000
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
Message-Id: <CAF=yD-LngkYq23Q2TCJv_0PRiAryznYRWRbqYFaQkNO=U0w9gQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
 <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com> <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
In-Reply-To: <CABeXuvoDPvT45CCt2L0TReqtb1Q_-E8+toYu6qjiP0cxfdQNdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, Nov 25, 2018 at 12:28 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > > > +       if (type = SO_TIMESTAMP_NEW || type = SO_TIMESTAMPNS_NEW)
> > > > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > > > +       else
> > > > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > > > +
> > >
> > > if adding a boolean whether the socket uses new or old-style
> > > timestamps, perhaps fail hard if a process tries to set a new-style
> > > option while an old-style is already set and vice versa. Also include
> > > SO_TIMESTAMPING_NEW as it toggles the same option.
>
> I do not think this is a problem.
> Consider this example, if there is a user application with updated
> socket timestamps is linking into a library that is yet to be updated.

Also consider applications that do not use libraries.

> Besides, the old timestamps should work perfectly fine on 64 bit
> arches even beyond 2038.

In that case, can we structure the code to not add branching on 64-bit
platforms.

For instance, structure

                  if (sock_flag(sk, SOCK_TSTAMP_NEW))
                           __sock_recv_timestamp_2038(msg, sk, skb);

instead as a boolean function that

                  if (__sock_recv_timestamp_2038(msg, sk, skb))

and have that function's contents wrapped in an ifdef that removes
it on 64-bit platforms and simply returns false?

Or more rigorously restrict these extensions to a 32-bit compat layer.

> So failing here means adding a bunch of ifdef's to verify it is not
> executing on 64 bit arch or something like x32.

The code as is adds branches on platforms that do not need it. Ifdefs
are ugly, but if they can be contained to the few helper functions needed
for the _2038 variants of cmsg_put, that is acceptable in my opinion.

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
> >
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

Yes, I know this socket timestamping code, but am less familiar with the
wider discusson on 2038 timestamp conversion. It would be helpful if this
patchset can be self-describing without that context or point to the
discussion (unfortunately, I had miss Arnd's talk at LPC).

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

So on 32-bit platforms SO_TIMESTAMP_NEW introduces a new struct
sock_timeval with both 64-bit fields.

Does this not break existing applications that compile against SO_TIMESTAMP
and expect struct timeval? For one example, the selftests under tools/testing.

The kernel will now convert SO_TIMESTAMP (previously constant 29) to
different SO_TIMESTAMP_NEW (62) and returns a different struct. Perhaps
with a library like libc in the middle this can be fixed up
transparently, but for
applications that don't have a more recent libc or use a library at
all, it breaks
the ABI.

I suspect that these finer ABI points may have been discussed outside the
narrow confines of socket timestamping. But on its own, this does worry me.
