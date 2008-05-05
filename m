From: DM <dm.n9107@gmail.com>
Date: Mon, 05 May 2008 08:30:09 +0000
Subject: Re: [PATCH v2] unify sys_pipe implementation
Message-Id: <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200805031801.m43I109q032242@devserv.devel.redhat.com>
In-Reply-To: <200805031801.m43I109q032242@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, torvalds@linux-foundation.org

On Sat, May 3, 2008 at 8:01 PM, Ulrich Drepper <drepper@redhat.com> wrote:
[...]
>   /*
>  + * sys_pipe() is the normal C calling standard for creating
>  + * a pipe. It's not the way Unix traditionally does this, though.
>  + */
>  +asmlinkage long sys_pipe(int __user *fildes)
>  +{
>  +       int fd[2];
>  +       int error;
>  +
>  +       error = do_pipe(fd);
>  +       if (!error) {
>  +               if (copy_to_user(fildes, fd, sizeof(fd)))
>  +                       error = -EFAULT;
>  +       }
>  +       return error;
>  +}
>  +
[...]

I realize this code is old, but wouldn't file descriptors leak if
copy_to_user fails?

BR,
dm.n9107
