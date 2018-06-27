From: Jann Horn <jannh@google.com>
Date: Wed, 27 Jun 2018 12:29:33 +0000
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
Message-Id: <CAG48ez2JAj1daM5s7gyS0nzB+J85PkmUL5+D_BC4-afag9SWFA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180625163410.216168-1-jannh@google.com> <20180625164109.GF30522@ZenIV.linux.org.uk>
 <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com> <d23cd44b1e2e1521cedb1c514d392263ed976dca.camel@decadent.org.uk>
In-Reply-To: <d23cd44b1e2e1521cedb1c514d392263ed976dca.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ben@decadent.org.uk, Al Viro <viro@zeniv.linux.org.uk>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, davem@davemloft.net, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, security@kernel.org, hch@infradead.org, serge@hallyn.com

On Tue, Jun 26, 2018 at 7:43 PM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Mon, 2018-06-25 at 20:16 +0200, Jann Horn wrote:
> > On Mon, Jun 25, 2018 at 6:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:
> > >
> > > > +     char tmp[32];
> > > >
> > > > -     if (namelen > 32)
> > > > +     if (namelen < 0 || namelen > 32)
> > > >               namelen = 32;
> > > >
> > > >       down_read(&uts_sem);
> > > >       kname = utsname()->domainname;
> > > >       len = strnlen(kname, namelen);
> > > > -     if (copy_to_user(name, kname, min(len + 1, namelen)))
> > > > -             err = -EFAULT;
> > > > +     len = min(len + 1, namelen);
> > > > +     memcpy(tmp, kname, len);
> > > >       up_read(&uts_sem);
> > > >
> > > > -     return err;
> > > > +     if (copy_to_user(name, tmp, len))
> > > > +             return -EFAULT;
> > >
> > > Infoleak, and similar in a lot of other places.
> >
> > I don't see a problem. copy_to_user() copies "len" bytes from "tmp".
> [...]
> > Can you please explain why there is an infoleak here?
>
> I think you're *fixing* information leaks in the Alpha syscalls,
> because a negative value of namelen used to result in a huge length
> argument to copy_to_user().

Ah, you're right. Looks like this was previously fixed in commit
21c5977a836e ("alpha: fix several security issues", first in v3.0),
and then un-fixed in commit 9ba3eb5103cf ("osf_getdomainname(): use
copy_to_user()", first in v4.13).
