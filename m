From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sun, 06 Aug 2017 18:22:03 +0000
Subject: Re: [PATCH] Fix compat_sys_sigpending breakage introduced by v4.13-rc1~6^2~12
Message-Id: <20170806182203.GA12956@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20170805200050.GA24804@altlinux.org>
In-Reply-To: <20170805200050.GA24804@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>, Eugene Syromyatnikov <evgsyr@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Aug 05, 2017 at 11:00:50PM +0300, Dmitry V. Levin wrote:
> The latest change of compat_sys_sigpending has broken it in two ways.
> 
> First, it tries to write 4 bytes more than userspace expects:
> sizeof(old_sigset_t) = sizeof(long) = 8 instead of
> sizeof(compat_old_sigset_t) = sizeof(u32) = 4.
> 
> Second, on big endian architectures these bytes are being written
> in the wrong order.

> @@ -3303,12 +3303,15 @@ SYSCALL_DEFINE1(sigpending, old_sigset_t __user *, set)
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE1(sigpending, compat_old_sigset_t __user *, set32)
>  {
> +#ifdef __BIG_ENDIAN
>  	sigset_t set;
> -	int err = do_sigpending(&set, sizeof(old_sigset_t)); 
> -	if (err = 0)
> -		if (copy_to_user(set32, &set, sizeof(old_sigset_t)))
> -			err = -EFAULT;
> +	int err = do_sigpending(&set, sizeof(set.sig[0]));
> +	if (!err)
> +		err = put_user(set.sig[0], set32);
>  	return err;
> +#else
> +	return sys_rt_sigpending((sigset_t __user *)set32, sizeof(*set32));
> +#endif

Interesting...  Basically, your fix makes it parallel to compat rt_sigpending(2);
I agree that the bug is real and gets fixed by that, but...  rt_sigpending()
itself looks a bit fishy.  There we have
                compat_sigset_t set32;
                sigset_to_compat(&set32, &set);
                /* we can get here only if sigsetsize <= sizeof(set) */
                if (copy_to_user(uset, &set32, sigsetsize))
                        err = -EFAULT;
in big-endian case; now, there are 4 callers of sigset_to_compat() in the
entire kernel.  One in sparc compat rt_sigaction(2), the rest in kernel/signal.c
itself.  All are followed by copy_to_user(), and all but the sparc one are
under that kind of "if it's big-endian..." ifdefs.

Looks like it might make sense to do this:
put_compat_sigset(compat_sigset_t __user *compat, const sigset_t *set, int size)
{
#ifdef 
	compat_sigset_t v;
        switch (_NSIG_WORDS) {
        case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
        case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
        case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
        case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
        }
	return copy_to_user(compat, &v, size) ? -EFAULT : 0;
#else
	return copy_to_user(compat, set, size) ? -EFAULT : 0;
#endif
}

int put_compat_old_sigset(compat_old_sigset_t __user *compat, const sigset_t *set)
{
	/* we want bits 0--31 of the bitmap */
	return put_user(compat, set->sig[0]);
}

in kernel/signal.c and turn e.g. compat rt_sigpending() into
COMPAT_SYSCALL_DEFINE2(rt_sigpending, compat_sigset_t __user *, uset,
                compat_size_t, sigsetsize)
{
        sigset_t set;
        int err = do_sigpending(&set, sigsetsize);
        if (!err)
		err = put_compat_sigset(uset, &set, sigsetsize);
        return err;
}

etc., including
COMPAT_SYSCALL_DEFINE2(sigpending, compat_old_sigset_t __user *, uset)
{
        sigset_t set;
        int err = do_sigpending(&set, sizeof(set));
        if (!err)
		err = put_compat_old_sigset(uset, &set);
        return err;
}

Incidentally, this
        if (sigsetsize > sizeof(sigset_t))
                return -EINVAL;
should probably be lifted out of do_sigpending() into rt_sigpending() and its
compat analog - sigsetsize argument is not used anywhere else in do_sigpending(),
and rt_sigpending() (and *especially* its compat counterpart) would be a lot
more obviously correct with that check done where it's seen.

Anyway, all of that can be done later; for now let's go with your patch.
ACKed-by: Al Viro <viro@zeniv.linux.org.uk>

I would pick it through my tree, but the local network is half-disasembled
for move (containers arrive tomorrow, flight to Boston on 9th, stuff should
arrive there by the weekend, so I hope to be back to normal by the 14th
or so, assuming I'll have any sanity left by that time).  Could somebody
else pick that one?  Linus?
