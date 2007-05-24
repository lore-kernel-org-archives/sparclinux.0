From: David Miller <davem@davemloft.net>
Date: Thu, 24 May 2007 20:45:12 +0000
Subject: Re: Linker script cleanup / consolidation
Message-Id: <20070524.134512.11647740.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200934.GB1109@uranus.ravnborg.org>
In-Reply-To: <20070524200934.GB1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 May 2007 22:09:34 +0200

> The other archs shall have a similar clean-up over time.
> sparc64 was just a good place to start because David had
> expressed that he liked the consolidation.

This looks great.  In fact I'd be happy with you pushing this
now for 2.6.22 in order to fix that RODATA() section alignment
bug.

On a related topic, I've been wondering how to make instruction
patching sections work with initdata without warning.  I have
a bunch of assembler patches in the main kernel image that go
something like this:

661:	ldx		[%g7 + TRAP_PER_CPU_TSB_HUGE], %g5
	nop
	.section	.sun4v_2insn_patch, "ax"
	.word		661b
	mov		SCRATCHPAD_UTSBREG2, %g5
	ldxa		[%g5] ASI_SCRATCHPAD, %g5
	.previous

And then an __init function walks the tables in the
".sun4v_2insn_patch" instruction to patch things as
needed.

I don't need to do this patching in modules or anything
complicated like that, just in the static kernel image.

The problem is if I put one of these patches into __init assembler
code, the modpost.c thing warns.  As you can see, these patch sections
in between __init_begin and __init_end.

I see that IA64 has something similar, and they prepend their
patch section names with ".data." would that help me with the
modpost.c warning issue?

The history behind this is that I want to make the assembler in
arch/sparc64/kernel/trampoline.S __init to fix one modpost.c
warning, but once I dod that I hit this patching section issue
which makes more warnings that the original problem :-)
