From: Changli Gao <xiaosuo@gmail.com>
Date: Wed, 22 Apr 2020 03:38:32 +0000
Subject: Re: [PATCH 1/4] fs: Implement close-on-fork
Message-Id: <CABa6K_HWsy9DdjsKXE2d_JrC+OsNuW+OALS+-_HiV3r2XgC1bw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200420071548.62112-2-nate.karstens@garmin.com> <36dce9b4-a0bf-0015-f6bc-1006938545b1@gmail.com>
In-Reply-To: <36dce9b4-a0bf-0015-f6bc-1006938545b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Nate Karstens <nate.karstens@garmin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Apr 20, 2020 at 6:25 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 4/20/20 12:15 AM, Nate Karstens wrote:
> > The close-on-fork flag causes the file descriptor to be closed
> > atomically in the child process before the child process returns
> > from fork(). Implement this feature and provide a method to
> > get/set the close-on-fork flag using fcntl(2).
> >
> > This functionality was approved by the Austin Common Standards
> > Revision Group for inclusion in the next revision of the POSIX
> > standard (see issue 1318 in the Austin Group Defect Tracker).
>
> Oh well... yet another feature slowing down a critical path.
>
> >
> > Co-developed-by: Changli Gao <xiaosuo@gmail.com>
> > Signed-off-by: Changli Gao <xiaosuo@gmail.com>
> > Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
> > ---
> >  fs/fcntl.c                             |  2 ++
> >  fs/file.c                              | 50 +++++++++++++++++++++++++-
> >  include/linux/fdtable.h                |  7 ++++
> >  include/linux/file.h                   |  2 ++
> >  include/uapi/asm-generic/fcntl.h       |  5 +--
> >  tools/include/uapi/asm-generic/fcntl.h |  5 +--
> >  6 files changed, 66 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index 2e4c0fa2074b..23964abf4a1a 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -335,10 +335,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> >               break;
> >       case F_GETFD:
> >               err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
> > +             err |= get_close_on_fork(fd) ? FD_CLOFORK : 0;
> >               break;
> >       case F_SETFD:
> >               err = 0;
> >               set_close_on_exec(fd, arg & FD_CLOEXEC);
> > +             set_close_on_fork(fd, arg & FD_CLOFORK);
> >               break;
> >       case F_GETFL:
> >               err = filp->f_flags;
> > diff --git a/fs/file.c b/fs/file.c
> > index c8a4e4c86e55..de7260ba718d 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -57,6 +57,8 @@ static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
> >       memset((char *)nfdt->open_fds + cpy, 0, set);
> >       memcpy(nfdt->close_on_exec, ofdt->close_on_exec, cpy);
> >       memset((char *)nfdt->close_on_exec + cpy, 0, set);
> > +     memcpy(nfdt->close_on_fork, ofdt->close_on_fork, cpy);
> > +     memset((char *)nfdt->close_on_fork + cpy, 0, set);
> >
>
> I suggest we group the two bits of a file (close_on_exec, close_on_fork) together,
> so that we do not have to dirty two separate cache lines.
>
> Otherwise we will add yet another cache line miss at every file opening/closing for processes
> with big file tables.
>
> Ie having a _single_ bitmap array, even bit for close_on_exec, odd bit for close_on_fork
>
> static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt)
> {
>         __set_bit(fd * 2, fdt->close_on_fork_exec);
> }
>
> static inline void __set_close_on_fork(unsigned int fd, struct fdtable *fdt)
> {
>         __set_bit(fd * 2 + 1, fdt->close_on_fork_exec);
> }
>
> Also the F_GETFD/F_SETFD implementation must use a single function call,
> to not acquire the spinlock twice.
>

Good suggestions.

At the same time, we'd better extend other syscalls, which set the
FD_CLOEXEC when  creating FDs. i.e. open, pipe3...


-- 
Regards,
Changli Gao(xiaosuo@gmail.com)
