From: Jann Horn <jannh@google.com>
Date: Mon, 25 Jun 2018 18:16:22 +0000
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
Message-Id: <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180625163410.216168-1-jannh@google.com> <20180625164109.GF30522@ZenIV.linux.org.uk>
In-Reply-To: <20180625164109.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, "David S. Miller" <davem@davemloft.net>, kernel list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, security@kernel.org, Christoph Hellwig <hch@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Mon, Jun 25, 2018 at 6:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:
>
> > +     char tmp[32];
> >
> > -     if (namelen > 32)
> > +     if (namelen < 0 || namelen > 32)
> >               namelen = 32;
> >
> >       down_read(&uts_sem);
> >       kname = utsname()->domainname;
> >       len = strnlen(kname, namelen);
> > -     if (copy_to_user(name, kname, min(len + 1, namelen)))
> > -             err = -EFAULT;
> > +     len = min(len + 1, namelen);
> > +     memcpy(tmp, kname, len);
> >       up_read(&uts_sem);
> >
> > -     return err;
> > +     if (copy_to_user(name, tmp, len))
> > +             return -EFAULT;
>
> Infoleak, and similar in a lot of other places.

I don't see a problem. copy_to_user() copies "len" bytes from "tmp".
The preceding memcpy() filled exactly those bytes, so I'm not leaking
stack memory. And "len" is bounded to "namelen", which is bounded to
32, which is smaller than __NEW_UTS_LEN, so I'm not leaking memory
from outside the bounds of utsname()->domainname.
And the contents of the "struct new_utsname" are completely
user-accessible (including bytes behind null terminators); you can see
that e.g. sys_newuname() copies the whole struct to userspace; this
seems to be intentional, if you e.g. look at how sys_sethostname() is
implemented.
I went over this function with a fine comb and didn't spot anything wrong:

SYSCALL_DEFINE2(osf_getdomainname, char __user *, name, int, namelen)
{
        int len, err = 0;
        char *kname;
        char tmp[32];

        if (namelen < 0 || namelen > 32)
                namelen = 32;
        // namelen in range 0..32

        down_read(&uts_sem);
        kname = utsname()->domainname;
        // kname points to a 65-byte buffer that userspace is permitted to read
        len = strnlen(kname, namelen); // strnlen() is bounded to
first 32 bytes of 65-byte buffer
        // len is in range 0..32
        len = min(len + 1, namelen);
        // min([0..32] + 1, [0..32]) = min([1..33], [0..32]) is in range 0..32
        memcpy(tmp, kname, len); // writes up to `len` bytes into tmp;
len<2, sizeof(tmp)=32; len<2, sizeof(utsname()->domainname)>32
        // userspace is permitted to read first `len` bytes of `tmp`
        up_read(&uts_sem);

        if (copy_to_user(name, tmp, len)) // first `len` bytes of
`tmp` are exposed to userspace
                return -EFAULT;
        return 0;
}

Can you please explain why there is an infoleak here?
