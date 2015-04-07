From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 07 Apr 2015 10:06:54 +0000
Subject: Re: [PATCH] signal: optimize 'sigaction' call path
Message-Id: <20150407100654.GA32743@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1428146533-2208-1-git-send-email-yury.norov@gmail.com>
In-Reply-To: <1428146533-2208-1-git-send-email-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yury.norov@gmail.com, rth@twiddle.net, ink@jurassic.park.msu.ru, akpm@linux-foundation.org, davem@davemloft.net
Cc: klimov.linux@gmail.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org

> There is a set of syscalls in the kernel about 'sigaction'.
> All they end up with calling the helper 'do_sigaction',
> so the generic scheme is:
>
> - copy user data to kernel;
> - 'do_sigaction';
> - copy kernel data to user.
>
> 'do_sigaction' checks 'signum' parameter before doing its main job.
> If this check fails syscall fails immediately, as well. But at this
> stage first copy is already done. And so there's a potential chance
> having it useless. It may affect performance significantly if user
> data was, say, swapped, and a fault was handled to obtain it.

Only if the signal number is wrong? So why do we care?

> In this patch, 'signum' sanity check is moved out of 'do_sigaction'
> to a small function 'user_signal'. So we can call it before any copying.
...
>  arch/alpha/kernel/signal.c       | 19 +++++++-------
>  arch/mips/kernel/signal.c        | 10 +++++---
>  arch/mips/kernel/signal32.c      | 10 +++++---
>  arch/sparc/kernel/sys_sparc32.c  | 10 ++++----
>  arch/sparc/kernel/sys_sparc_32.c | 10 ++++----
>  arch/sparc/kernel/sys_sparc_64.c | 10 ++++----
>  include/linux/sched.h            |  2 +-
>  include/linux/signal.h           |  5 ++++
>  kernel/signal.c                  | 54 +++++++++++++++++++++-------------------
>  9 files changed, 71 insertions(+), 59 deletions(-)

And this blows the source and compiled code. Not too much, but this
change should be justified somehow.

And to me this patch doesn't look like a cleanup, imho this sanity
check makes more sense in one place.

Oleg.

