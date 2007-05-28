From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 28 May 2007 18:53:36 +0000
Subject: Re: Linker script cleanup / consolidation
Message-Id: <20070528185336.GA31031@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200934.GB1109@uranus.ravnborg.org>
In-Reply-To: <20070524200934.GB1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> On a related topic, I've been wondering how to make instruction
> patching sections work with initdata without warning.  I have
> a bunch of assembler patches in the main kernel image that go
> something like this:
> 
> 661:	ldx		[%g7 + TRAP_PER_CPU_TSB_HUGE], %g5
> 	nop
> 	.section	.sun4v_2insn_patch, "ax"
> 	.word		661b
> 	mov		SCRATCHPAD_UTSBREG2, %g5
> 	ldxa		[%g5] ASI_SCRATCHPAD, %g5
> 	.previous
> 
> And then an __init function walks the tables in the
> ".sun4v_2insn_patch" instruction to patch things as
> needed.
> 
> I don't need to do this patching in modules or anything
> complicated like that, just in the static kernel image.
> 
> The problem is if I put one of these patches into __init assembler
> code, the modpost.c thing warns.  As you can see, these patch sections
> in between __init_begin and __init_end.
> 
> I see that IA64 has something similar, and they prepend their
> patch section names with ".data." would that help me with the
> modpost.c warning issue?
> 
> The history behind this is that I want to make the assembler in
> arch/sparc64/kernel/trampoline.S __init to fix one modpost.c
> warning, but once I dod that I hit this patching section issue
> which makes more warnings that the original problem :-)

First off. I tried building a sparc64 kernel from -linus using
defconfig and got no section mismatch warnings.
Building a ia64 kernel now...

What we can do in modpost is to define that references from a certain
section or sections that start with for example ".patch_insn."
to .init.text / .init.data will be ignored.
Avoiding hardcoding ".sun4v_*" would be preferred and maybe
we could move paravirt over to use a section with the same naming
convention.

Trying to cheat modpost is only a source of confusion and thats
not the way to do it.

	Sam

