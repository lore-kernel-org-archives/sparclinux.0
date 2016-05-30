From: Nix <nix@esperi.org.uk>
Date: Mon, 30 May 2016 12:43:01 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <878tyrvhre.fsf@esperi.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <87fut34unx.fsf@esperi.org.uk> <87fut34unx.fsf@esperi.org.uk>
	<87twhj3ag0.fsf@esperi.org.uk>
	<20160528.230250.216567426920998466.davem@davemloft.net>
In-Reply-To: <20160528.230250.216567426920998466.davem@davemloft.net> (David
	Miller's message of "Sat, 28 May 2016 23:02:50 -0700 (PDT)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

On 29 May 2016, David Miller spake thusly:

> BTW Nick, in thinking through all of this, I want to strongly encourage
> you to disable stack protector for all sigreturn stubs in the GLIBC tree.

I completely concur, and have already written (but not committed) a
patch to do this: I'll augment the existing sparc-only patch into a
sigreturn-stubs patch. I *think* I spotted all the stubs. (Many of them
are in assembler, but not all.)

(If there's anything else which involves calling functions with a
precisely-aligned stack and an expectation of no stack pointer movement
in the prologue or epilogue, I'd be interested to know about it, since
that'll need inhibit_stack_protector'ing too.)

-- 
NULL && (void)
