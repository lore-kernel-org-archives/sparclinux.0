From: Dave Martin <Dave.Martin@arm.com>
Date: Tue, 17 Apr 2018 13:23:30 +0000
Subject: Re: [RFC PATCH 1/3] signal: Ensure every siginfo we send has all bits initialized
Message-Id: <20180417132328.GF16308@e103592.cambridge.arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
 <20180413175407.GO16141@n2100.armlinux.org.uk>
 <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
 <20180413184522.GD16308@e103592.cambridge.arm.com>
 <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
 <20180415131206.GR16141@n2100.armlinux.org.uk>
 <87604sa2fu.fsf_-_@xmission.com>
 <87zi248nte.fsf_-_@xmission.com>
In-Reply-To: <87zi248nte.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, sparclinux <sparclinux@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sun, Apr 15, 2018 at 10:57:33AM -0500, Eric W. Biederman wrote:
> 
> Call clear_siginfo to ensure every stack allocated siginfo is properly
> initialized before being passed to the signal sending functions.
> 
> Note: It is not safe to depend on C initializers to initialize struct
> siginfo on the stack because C is allowed to skip holes when
> initializing a structure.
> 
> The initialization of struct siginfo in tracehook_report_syscall_exit
> was moved from the helper user_single_step_siginfo into
> tracehook_report_syscall_exit itself, to make it clear that the local
> variable siginfo gets fully initialized.
> 
> In a few cases the scope of struct siginfo has been reduced to make it
> clear that siginfo siginfo is not used on other paths in the function
> in which it is declared.
> 
> Instances of using memset to initialize siginfo have been replaced
> with calls clear_siginfo for clarity.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

[...]

Hmmm

memset()/clear_siginfo() may ensure that there are no uninitialised
explicit fields except for those in inactive union members, but I'm not
sure that this approach is guaranteed to sanitise the padding seen by
userspace.

Rationale below, though it's a bit theoretical...

With this in mind, I tend agree with Linus that hiding memset() calls
from the maintainer may be a bad idea unless they are also hidden from
the compiler.  If the compiler sees the memset() it may be able to
optimise it in ways that wouldn't be possible for some other random
external function call, including optimising all or part of the call
out.

As a result, the breakdown into individual put_user()s etc. in
copy_siginfo_to_user() may still be valuable even if all paths have the
memset().


(Rationale for an arch/arm example:)

> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index 4c375e11ae95..adda3fc2dde8 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -218,8 +218,7 @@ static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
>  {
>  	siginfo_t info;
>  
> -	memset(&info, 0, sizeof(info));
> -
> +	clear_siginfo(&info);
>  	info.si_signo = SIGFPE;

/* by c11 (n1570) 6.2.6.1 para 6 [1], all padding bytes in info now take
   unspecified values */

>  	info.si_code = sicode;
>  	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);

/* by c11 (n1570) 6.2.6.1 para 7 [2], all bytes of the union info._sifields
   other than than those corresponding to _sigfault take unspecified
   values */

So I don't see why the compiler needs to ensure that any of the affected
bytes are zero: it could potentially skip a lot of the memset() as a
result, in theory.

I've not seen a compiler actually take advantage of that, but I'm now
not sure what forbids it.


If this can happen, I only see two watertight workarounds:

1) Ensure that there is no implicit padding in any UAPI structure, e.g.
aeb1f39d814b: ("arm64/ptrace: Avoid uninitialised struct padding in
fpr_set()").  This would include tail-padding of any union member that
is smaller than the containing union.

It would be significantly more effort to ensure this for siginfo though.

2) Poke all values directly into allocated or user memory directly
via pointers to paddingless types; never assign to objects on the kernel
stack if you care what ends up in the padding, e.g., what your
copy_siginfo_to_user() does prior to this series.


If I'm not barking up the wrong tree, memset() cannot generally be
used to determine the value of padding bytes, but it may still be
useful for forcing otherwise uninitialised members to sane initial
values.

This likely affects many more things than just siginfo.

[...]

Cheers
---Dave

[1] n1570 6.2.6.1.6: When a value is stored in an object of structure or
union type, including in a member object, the bytes of the object
representation that correspond to any padding bytes take unspecified
values [...]

[2] n1570 6.2.6.1.7: When a value is stored in a member of an object of
union type, the bytes of the object representation that do not
correspond to that member but do correspond to other members take
unspecified values.
