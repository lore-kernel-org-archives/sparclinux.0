From: Ralf Baechle <ralf@linux-mips.org>
Date: Mon, 05 May 2008 10:18:09 +0000
Subject: Re: [PATCH v2] unify sys_pipe implementation
Message-Id: <20080505101809.GA14547@linux-mips.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200805031801.m43I109q032242@devserv.devel.redhat.com> <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
In-Reply-To: <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DM <dm.n9107@gmail.com>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, torvalds@linux-foundation.org

On Mon, May 05, 2008 at 10:30:09AM +0200, DM wrote:

> >  + * sys_pipe() is the normal C calling standard for creating
> >  + * a pipe. It's not the way Unix traditionally does this, though.
> >  + */
> >  +asmlinkage long sys_pipe(int __user *fildes)
> >  +{
> >  +       int fd[2];
> >  +       int error;
> >  +
> >  +       error = do_pipe(fd);
> >  +       if (!error) {
> >  +               if (copy_to_user(fildes, fd, sizeof(fd)))
> >  +                       error = -EFAULT;
> >  +       }
> >  +       return error;
> >  +}
> >  +
> [...]
> 
> I realize this code is old, but wouldn't file descriptors leak if
> copy_to_user fails?

The MIPS implementation doesn't have this problem; it returns the
file descriptors in the result registers $v0 and $v1.

But an interesting catch after so many years!

  Ralf
