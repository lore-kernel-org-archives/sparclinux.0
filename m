From: "Michael Kerrisk" <mtk.manpages@gmail.com>
Date: Mon, 05 May 2008 09:15:53 +0000
Subject: Re: [PATCH v2] unify sys_pipe implementation
Message-Id: <517f3f820805050215s689ae274yf8a4ad270cb5981c@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200805031801.m43I109q032242@devserv.devel.redhat.com>
	 <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
In-Reply-To: <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DM <dm.n9107@gmail.com>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, torvalds@linux-foundation.org

On 5/5/08, DM <dm.n9107@gmail.com> wrote:
> On Sat, May 3, 2008 at 8:01 PM, Ulrich Drepper <drepper@redhat.com> wrote:
>  [...]
>
> >   /*
>  >  + * sys_pipe() is the normal C calling standard for creating
>  >  + * a pipe. It's not the way Unix traditionally does this, though.
>  >  + */
>  >  +asmlinkage long sys_pipe(int __user *fildes)
>  >  +{
>  >  +       int fd[2];
>  >  +       int error;
>  >  +
>  >  +       error = do_pipe(fd);
>  >  +       if (!error) {
>  >  +               if (copy_to_user(fildes, fd, sizeof(fd)))
>  >  +                       error = -EFAULT;
>  >  +       }
>  >  +       return error;
>  >  +}
>  >  +
>
> [...]
>
>  I realize this code is old, but wouldn't file descriptors leak if
>  copy_to_user fails?

Yes, it does -- I just tested this.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
