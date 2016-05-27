From: Nick Alcock <nix@esperi.org.uk>
Date: Fri, 27 May 2016 21:44:56 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <8760tz2n1j.fsf@esperi.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <87fut34unx.fsf@esperi.org.uk> <87fut34unx.fsf@esperi.org.uk>
	<87twhj3ag0.fsf@esperi.org.uk>
	<20160527.123731.2105286005500436503.davem@davemloft.net>
In-Reply-To: <20160527.123731.2105286005500436503.davem@davemloft.net> (David
	Miller's message of "Fri, 27 May 2016 12:37:31 -0700 (PDT)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

On 27 May 2016, David Miller stated:

> From: Nick Alcock <nix@esperi.org.uk>
> Date: Fri, 27 May 2016 14:19:27 +0100
>
>> The only difference between the two series above is that in the crashing
>> series, the ka_restorer stub functions __rt_sigreturn_stub and
>> __sigreturn_stub (on sparc32) and __rt_sigreturn_stub (on sparc64) get
>> stack-protected; in the non-crashing series, they do not; the same is
>> true without --enable-stack-protector=all, because the functions have no
>> local variables at all, so without -fstack-protector-all they don't get
>> stack-protected in any case. Passing such a stack-protected function in
>> as the ka_restorer stub seems to suffice to cause this crash at some
>> later date. I'm wondering if the stack canary is clobbering something
>> that the caller does not expect to be clobbered: we saw this cause
>> trouble on x86 in a different context (see upstream commit
>> 7a25d6a84df9fea56963569ceccaaf7c2a88f161).
>
> This is amazing that it makes a difference since the sigreturn stub is
> implemented entirely in inline assembler :-)

I was fairly surprised as well, but not shocked, because people who
write a function that consists of one single inline assembler
instruction might well be rather surprised to find a massive pile of
prologue and epilogue code dumped around it!

> Normally the 64-bit stub is emitted as:
>
> __rt_sigreturn_stub:
>         mov 101, %g1
>         ta 0x6d
>
> and with -fstack-protector-all we get:
>
> __rt_sigreturn_stub:
>         save    %sp, -192, %sp
>         ldx     [%g7+40], %g1
>         stx     %g1, [%fp+2039]
>         mov     0, %g1
>
>         mov 101, %g1
>         ta 0x6d
>
>         ldx     [%fp+2039], %g1
>         ldx     [%g7+40], %g2
>         xor     %g1, %g2, %g1
>         mov     0, %g2
>         brnz,pn %g1, .LL4
>          nop
>         return  %i7+8
>          nop
> .LL4:
>         call    __stack_chk_fail, 0
>          nop
>         nop
>
> That 'save' is the problem.
>
> One can't change the register window or the stack pointer in this
> function, as the kernel has setup the restore frame at a precise
> location relative to the stack pointer when the stub is invoked.

Oops!

> Basically, do_rt_sigreturn is restoring garbage into the cpu
> registers.

Oh gods is it supposed to do register restoration? i.e. the usual ABI
rules in re stack changes, etc just don't apply to it?

Right, that's a disaster for stack-protection, obviously. The
stack-protector prologue/epilogue does rather assume that it's being
wrapped around a function, and in a very real sense this thing isn't a
function in the normal sense at all. This is exactly what I thought was
going on with the x86 code, but in the end that turned out to be a
simple case of the (assembly) caller assuming a call-clobbered register
had survived unchanged when the stack-protector epilogue had clobbered
it (as it was quite within its rights to).

> It obviously shouldn't crash, which I'll look into, but it is clear
> that we can't enable -fstack-protector-all for this function.

And now I have a good explanation of why that is for the commit log.
Thank you!

> So far I'm playing with the patch below to do some basic sanity
> checks on the values inside of the sigreturn frame:

Good move. Segfaulting the process is fine! :) Any process that does
this sort of thing is clearly either terminally buggy, written by an
idiot who doesn't know what he's doing (i.e. my original patch) or
malicious. These all deserve SEGVs.

(I still don't understand why this leads to spurious TLB faults, though.
Filling the userland CPU registers with garbage is bad, but should still
be reasonably harmless to the kernel, surely?)

-- 
NULL && (void)
