From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 20 Sep 2020 00:14:41 +0000
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-Id: <CALCETrViwOdFia_aX4p4riE8aqop1zoOqVfiQtSAZEzheC+Ozg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919224122.GJ3421308@ZenIV.linux.org.uk> <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
 <20200919232411.GK3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200919232411.GK3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>

On Sat, Sep 19, 2020 at 4:24 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 19, 2020 at 03:53:40PM -0700, Andy Lutomirski wrote:
>
> > > It would not be a win - most of the syscalls don't give a damn
> > > about 32bit vs. 64bit...
> >
> > Any reasonable implementation would optimize it out for syscalls that d=
on=E2=80=99t care.  Or it could be explicit:
> >
> > DEFINE_MULTIARCH_SYSCALL(...)
>
> 1) what would that look like?

In effect, it would work like this:

/* Arch-specific, but there's a generic case for sane architectures. */
enum syscall_arch {
  SYSCALL_NATIVE,
  SYSCALL_COMPAT,
  SYSCALL_X32,
};

DEFINE_MULTIARCH_SYSCALLn(args, arch)
{
  args are the args here, and arch is the arch.
}

> 2) have you counted the syscalls that do and do not need that?

No.

> 3) how many of those realistically *can* be unified with their
> compat counterparts?  [hint: ioctl(2) cannot]

There would be no requirement to unify anything.  The idea is that
we'd get rid of all the global state flags.

For ioctl, we'd have a new file_operation:

long ioctl(struct file *, unsigned int, unsigned long, enum syscall_arch);

I'm not saying this is easy, but I think it's possible and the result
would be more obviously correct than what we have now.
