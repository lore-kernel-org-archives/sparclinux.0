From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 03 May 2008 18:40:18 +0000
Subject: Re: [PATCH v2] unify sys_pipe implementation
Message-Id: <alpine.LFD.1.10.0805031138450.5994@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200805031801.m43I109q032242@devserv.devel.redhat.com>
In-Reply-To: <200805031801.m43I109q032242@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org



On Sat, 3 May 2008, Ulrich Drepper wrote:
> 
> Some arch maintainers might want to take a look at their remaining
> special versions.  The cris version, for instance, only differs from
> the generic version in that it takes the BKL.  Is this still needed
> these days?

No, definitely not.

That said, I think that in order to not break other architectures, and to 
make it even easier to do this transformation, how about we just mark the 
generic version with __weak?

That way, odd architectures can just continue to call their own versions 
"sys_pipe()", and we don't break them unnecessarily.

		Linus
