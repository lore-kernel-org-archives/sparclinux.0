From: David Miller <davem@davemloft.net>
Date: Sun, 29 May 2016 06:02:50 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <20160528.230250.216567426920998466.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87fut34unx.fsf@esperi.org.uk>
	<87fut34unx.fsf@esperi.org.uk>
	<87twhj3ag0.fsf@esperi.org.uk>
In-Reply-To: <87twhj3ag0.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nix@esperi.org.uk
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

From: Nick Alcock <nix@esperi.org.uk>
Date: Fri, 27 May 2016 14:19:27 +0100

> The only difference between the two series above is that in the crashing
> series, the ka_restorer stub functions __rt_sigreturn_stub and
> __sigreturn_stub (on sparc32) and __rt_sigreturn_stub (on sparc64) get
> stack-protected; in the non-crashing series, they do not; the same is
> true without --enable-stack-protector=all, because the functions have no
> local variables at all, so without -fstack-protector-all they don't get
> stack-protected in any case. Passing such a stack-protected function in
> as the ka_restorer stub seems to suffice to cause this crash at some
> later date. I'm wondering if the stack canary is clobbering something
> that the caller does not expect to be clobbered: we saw this cause
> trouble on x86 in a different context (see upstream commit
> 7a25d6a84df9fea56963569ceccaaf7c2a88f161).
> 
> It is clearly acceptable to say "restorer stubs are incompatible with
> stack-protector canaries: turn them off" -- there are plenty of places
> that are incompatible with canaries for good reason, and quite a lot of
> the glibc patch series has been identifying these and turning the stack-
> protector off for them -- but it is probably less acceptable to crash
> the kernel if they don't do that! So at least some extra armouring seems
> to be called for.

BTW Nick, in thinking through all of this, I want to strongly encourage
you to disable stack protector for all sigreturn stubs in the GLIBC tree.

The reason is that any change in the code generated is going to break
critical pieces of infrastructure.

For example, one of the ways in which gdb knows that it is unwinding
through a signal frame is that it parses the code at the program
counter for that frame and looks at the instruction sequence to see if
matches the signature for a sigreturn stub.

So a glibc with stack protector enabled for sigreturn stubs would break
backtracing in gdb.

The unwinder in libgcc does the same exact thing.
