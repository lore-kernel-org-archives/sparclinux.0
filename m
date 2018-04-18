From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 18 Apr 2018 14:22:09 +0000
Subject: Re: [RFC PATCH 1/3] signal: Ensure every siginfo we send has all bits initialized
Message-Id: <87h8o8y4q6.fsf@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
        <87604sa2fu.fsf_-_@xmission.com> <87zi248nte.fsf_-_@xmission.com>
        <20180417132328.GF16308@e103592.cambridge.arm.com>
        <87d0yxzksd.fsf@xmission.com>
        <20180418124717.GI16308@e103592.cambridge.arm.com>
In-Reply-To: <20180418124717.GI16308@e103592.cambridge.arm.com> (Dave Martin's
        message of "Wed, 18 Apr 2018 13:47:18 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, sparclinux <sparclinux@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Dave Martin <Dave.Martin@arm.com> writes:

> On Tue, Apr 17, 2018 at 02:37:38PM -0500, Eric W. Biederman wrote:
>> Dave Martin <Dave.Martin@arm.com> writes:
>> 
>> > Hmmm
>> >
>> > memset()/clear_siginfo() may ensure that there are no uninitialised
>> > explicit fields except for those in inactive union members, but I'm not
>> > sure that this approach is guaranteed to sanitise the padding seen by
>> > userspace.
>> >
>> > Rationale below, though it's a bit theoretical...
>> >
>> > With this in mind, I tend agree with Linus that hiding memset() calls
>> > from the maintainer may be a bad idea unless they are also hidden from
>> > the compiler.  If the compiler sees the memset() it may be able to
>> > optimise it in ways that wouldn't be possible for some other random
>> > external function call, including optimising all or part of the call
>> > out.
>> >
>> > As a result, the breakdown into individual put_user()s etc. in
>> > copy_siginfo_to_user() may still be valuable even if all paths have the
>> > memset().
>> 
>> The breakdown into individual put_user()s is known to be problematically
>> slow, and is actually wrong.
>
> Slowness certainly looked like a potential problem.
>
>> Even exclusing the SI_USER duplication in a small number of cases the
>> fields filled out in siginfo by architecture code are not the fields
>> that copy_siginfo_to_user is copying.  Which is much worse.  The code
>> looks safe but is not.
>> 
>> My intention is to leave 0 instances of clear_siginfo in the
>> architecture specific code.  Ideally struct siginfo will be limited to
>> kernel/signal.c but I am not certain I can quite get that far.
>> The function do_coredump appears to have a legit need for siginfo.
>
> So, you mean we can't detect that the caller didn't initialise all the
> members, or initialised the wrong union member?

Correct.  Even when we smuggled the the union member in the upper bits
of si_code we got it wrong.  So an interface that helps out and does
more and is harder to misues looks desirable.

> What would be the alternative?  Have a separate interface for each SIL_
> type, with only kernel/signal.c translating that into the siginfo_t that
> userspace sees?

Yes.  It really isn't bad as architecture specific code only generates
faults.  In general faults only take a pointer.  I have already merged
the needed helpers into kernel/signal.c

> Either way, I don't see how we force the caller to initilise the whole
> structure.

In general the plan is to convert the callers to call force_sig_fault,
and then there is no need to have siginfo in the architecture specific
code.  I have all of the necessary helpers are already merged into
kernel/signal.c

>
>> > (Rationale for an arch/arm example:)
>> >
>> >> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
>> >> index 4c375e11ae95..adda3fc2dde8 100644
>> >> --- a/arch/arm/vfp/vfpmodule.c
>> >> +++ b/arch/arm/vfp/vfpmodule.c
>> >> @@ -218,8 +218,7 @@ static void vfp_raise_sigfpe(unsigned int sicode, struct pt_regs *regs)
>> >>  {
>> >>  	siginfo_t info;
>> >>  
>> >> -	memset(&info, 0, sizeof(info));
>> >> -
>> >> +	clear_siginfo(&info);
>> >>  	info.si_signo = SIGFPE;
>> >
>> > /* by c11 (n1570) 6.2.6.1 para 6 [1], all padding bytes in info now take
>> >    unspecified values */
>> >
>> >>  	info.si_code = sicode;
>> >>  	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
>> >
>> > /* by c11 (n1570) 6.2.6.1 para 7 [2], all bytes of the union info._sifields
>> >    other than than those corresponding to _sigfault take unspecified
>> >    values */
>> >
>> > So I don't see why the compiler needs to ensure that any of the affected
>> > bytes are zero: it could potentially skip a lot of the memset() as a
>> > result, in theory.
>> >
>> > I've not seen a compiler actually take advantage of that, but I'm now
>> > not sure what forbids it.
>> 
>> I took a quick look at gcc-4.9 which I have handy.
>> 
>> The passes -f-no-strict-aliasing which helps, and gcc actually
>> documents that if you access things through the union it will
>> not take advantage of c11.
>> 
>> gcc-4.9 Documents it this way:
>> 
>> > -fstrict-aliasing'
>> >      Allow the compiler to assume the strictest aliasing rules
>> >      applicable to the language being compiled.  For C (and C++), this
>> >      activates optimizations based on the type of expressions.  In
>> >      particular, an object of one type is assumed never to reside at the
>> >      same address as an object of a different type, unless the types are
>> >      almost the same.  For example, an 'unsigned int' can alias an
>> >      'int', but not a 'void*' or a 'double'.  A character type may alias
>> >      any other type.
>> > 
>> >      Pay special attention to code like this:
>> >           union a_union {
>> >             int i;
>> >             double d;
>> >           };
>> > 
>> >           int f() {
>> >             union a_union t;
>> >             t.d = 3.0;
>> >             return t.i;
>> >           }
>> >      The practice of reading from a different union member than the one
>> >      most recently written to (called "type-punning") is common.  Even
>> >      with '-fstrict-aliasing', type-punning is allowed, provided the
>> >      memory is accessed through the union type.  So, the code above
>> >      works as expected.
>
> This makes the C standard look precise (I love the "works as expected"),
> and says nothing about the cumulative effect of assigning to multiple
> members of a union, or about the effects on padding bytes.
>
> I'm not convinced that all of this falls under strict-aliasing, but
> I'd have to do more digging to confirm it.

>> > If this can happen, I only see two watertight workarounds:
>> >
>> > 1) Ensure that there is no implicit padding in any UAPI structure, e.g.
>> > aeb1f39d814b: ("arm64/ptrace: Avoid uninitialised struct padding in
>> > fpr_set()").  This would include tail-padding of any union member that
>> > is smaller than the containing union.
>> >
>> > It would be significantly more effort to ensure this for siginfo though.
>> >
>> > 2) Poke all values directly into allocated or user memory directly
>> > via pointers to paddingless types; never assign to objects on the kernel
>> > stack if you care what ends up in the padding, e.g., what your
>> > copy_siginfo_to_user() does prior to this series.
>> >
>> >
>> > If I'm not barking up the wrong tree, memset() cannot generally be
>> > used to determine the value of padding bytes, but it may still be
>> > useful for forcing otherwise uninitialised members to sane initial
>> > values.
>> >
>> > This likely affects many more things than just siginfo.
>> 
>> Unless gcc has changed it's stance on type-punning through unions
>> or it's semantics with -fno-strict_aliasing we should be good.
>
> In practice you're probably right.
>
> Today, gcc is pretty conservative in this area, and I haven't been able
> to convince clang to optimise away memset in this way either.
>
> My concern is that is this assumption turns out to be wrong it may be
> some time before anybody notices, because the leakage of kernel stack may
> be the only symptom.
>
> I'll try to nail down a compiler guy to see if we can get a promise on
> this at least with -fno-strict-aliasing.
>
>
> I wonder whether it's worth protecting ourselves with something like:
>
>
> static void clear_siginfo(siginfo_t *si)
> {
> 	asm ("" : "=m" (*si));
> 	memset(si, 0, sizeof(*si));
> 	asm ("" : "+m" (*si));
> }
>
> Probably needs to be thought about more widely though.  I guess it's out
> of scope for this series.

It is definitely a question worth asking.

Eric
