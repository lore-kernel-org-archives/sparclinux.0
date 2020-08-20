From: David Miller <davem@davemloft.net>
Date: Thu, 20 Aug 2020 22:51:22 +0000
Subject: Re: [sparc32] userland unaligned access
Message-Id: <20200820.155122.2263405333608231817.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200820193612.GG1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200820193612.GG1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 20 Aug 2020 20:36:12 +0100

> 	We have
> asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn)
> {
>         enum direction dir;
> 
>         if(!(current->thread.flags & SPARC_FLAG_UNALIGNED) ||
>            (((insn >> 30) & 3) != 3))
>                 goto kill_user;
> 
> there, followed by some work on emulating the insn.  So while the default
> behaviour is to hit the process with SIGBUS, it can overridden by setting
> SPARC_FLAG_UNALIGNED in current->thread.flags.  Fair enough, but...  Just
> what could possibly set that flag?
> 
> That stuff had been introduced back in 2.1.9 and even there (or through
> the 2.2, etc.) I don't see anything that would ever set it.
> 
> Am I missing something, or had it really been dead code all along?

Relic from the SunOS and/or Solaris syscall emulation probably.
