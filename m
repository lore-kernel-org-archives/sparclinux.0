From: David Miller <davem@davemloft.net>
Date: Thu, 20 Aug 2020 23:47:08 +0000
Subject: Re: [sparc32] userland unaligned access
Message-Id: <20200820.164708.2016059081784711542.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200820193612.GG1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200820193612.GG1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 21 Aug 2020 00:37:30 +0100

> On Thu, Aug 20, 2020 at 03:51:22PM -0700, David Miller wrote:
>> From: Al Viro <viro@zeniv.linux.org.uk>
>> Date: Thu, 20 Aug 2020 20:36:12 +0100
>> 
>> > 	We have
>> > asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn)
>> > {
>> >         enum direction dir;
>> > 
>> >         if(!(current->thread.flags & SPARC_FLAG_UNALIGNED) ||
>> >            (((insn >> 30) & 3) != 3))
>> >                 goto kill_user;
>> > 
>> > there, followed by some work on emulating the insn.  So while the default
>> > behaviour is to hit the process with SIGBUS, it can overridden by setting
>> > SPARC_FLAG_UNALIGNED in current->thread.flags.  Fair enough, but...  Just
>> > what could possibly set that flag?
>> > 
>> > That stuff had been introduced back in 2.1.9 and even there (or through
>> > the 2.2, etc.) I don't see anything that would ever set it.
>> > 
>> > Am I missing something, or had it really been dead code all along?
>> 
>> Relic from the SunOS and/or Solaris syscall emulation probably.
> 
> Thought so, but...  no such thing in either.  And it's not done from assembler -
> arch/sparc64 used to access ->tss.flags that way (and that was only for
> SPARC_FLAG_NEWCHILD), but arch/sparc never did...
> 
> I don't have sunos toolchain to try and build such a binary and test it on
> a 2.2 kernel, but I would be rather surprised if that had been it.
> 
> Anyway, it really looks like that's dead code these days...

%100 it is dead code.
