From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 08 Jan 2019 21:19:05 +0000
Subject: Re: [PATCH 2/3] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
Message-Id: <CABeXuvptd3G0kZ7K7j78cSGOnxBOkCoDe8Tzhfu4BQcYVtJNPg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
 <20190108052255.10699-3-deepa.kernel@gmail.com> <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
In-Reply-To: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, ccaulfie@redhat.com, Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, cluster-devel <cluster-devel@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Tue, Jan 8, 2019 at 12:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 8, 2019 at 6:24 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
> > as the time format. struct timeval is not y2038 safe.
> > The subsequent patches in the series add support for new socket
> > timeout options with _NEW suffix that are y2038 safe.
> > Rename the existing options with _OLD suffix forms so that the
> > right option is enabled for userspace applications according
> > to the architecture and time_t definition of libc.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>
> Looks good overall. A few minor concerns:
>
> The description above makes it sound like there is a bug with y2038-safety
> in this particular interface, which I think is just not what you meant,
> as the change is only needed for compatiblity with new C libraries
> that work around the y2038 problem in general by changing their
> timeval definition.

Right, there is y2038 safety issue, just the libc part that needs to be handled.
I will fix the commit text.

> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 76976d6e50f9..c98ad9777ad9 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -1089,12 +1089,12 @@ static void sctp_connect_to_sock(struct connection *con)
> >          * since O_NONBLOCK argument in connect() function does not work here,
> >          * then, we should restore the default value of this attribute.
> >          */
> > -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> > +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
> >                           sizeof(tv));
> >         result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
> >                                    0);
> >         memset(&tv, 0, sizeof(tv));
> > -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> > +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
> >                           sizeof(tv));
> >
> >         if (result = -EINPROGRESS)
>
> It took me a bit to realize there that this is safe as well even if
> we don't use SO_SNDTIMEO_NEW, for the same reason.

Correct.

> > --- a/net/compat.c
> > +++ b/net/compat.c
> > @@ -378,7 +378,7 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
> >                 return do_set_attach_filter(sock, level, optname,
> >                                             optval, optlen);
> >         if (!COMPAT_USE_64BIT_TIME &&
> > -           (optname = SO_RCVTIMEO || optname = SO_SNDTIMEO))
> > +           (optname = SO_RCVTIMEO_OLD || optname = SO_SNDTIMEO_OLD))
> >                 return do_set_sock_timeout(sock, level, optname, optval, optlen);
> >
> >         return sock_setsockopt(sock, level, optname, optval, optlen);
> > @@ -450,7 +450,7 @@ static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
> >                                 char __user *optval, int __user *optlen)
> >  {
> >         if (!COMPAT_USE_64BIT_TIME &&
> > -           (optname = SO_RCVTIMEO || optname = SO_SNDTIMEO))
> > +           (optname = SO_RCVTIMEO_OLD || optname = SO_SNDTIMEO_OLD))
> >                 return do_get_sock_timeout(sock, level, optname, optval, optlen);
> >         return sock_getsockopt(sock, level, optname, optval, optlen);
> >  }
>
> I looked at the original code and noticed that it's horrible, which of course
> is not your fault, but I wonder if we should just fix it now to avoid that
> get_fs()/set_fs() hack, since that code mostly implements what you
> also have in your patch 3 (which is done more nicely).

I did think of getting rid of set_fs()/ get_fs() here.
But, I wasn't sure as the maintainers seemed to prefer to leave to the
old code as is in the other series for timestamps.

> I'll follow up with a patch to demonstrate what I mean here. Your third
> patch will then just have to add another code path so we can handle
> all of old_timespec32 (for existing 32-bit user space), __kernel_old_timespec
> (for sparc64) and __kernel_sock_timeval (for everything else).

Cool, I will rebase on top of your patch.

Thanks,
Deepa
