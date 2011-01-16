From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Sun, 16 Jan 2011 14:17:49 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295187469.22527.13.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <20110113.155700.102679408.davem@davemloft.net>
	 <4D302B2F.7030108@oldelvet.org.uk> <4D3074FE.3030707@oldelvet.org.uk>
	 <20110115.211722.39173519.davem@davemloft.net>
In-Reply-To: <20110115.211722.39173519.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com

On Sat, 2011-01-15 at 21:17 -0800, David Miller wrote:
> From: Richard Mortimer <richm@oldelvet.org.uk>
> Date: Fri, 14 Jan 2011 16:08:30 +0000
> 
> [ Frederic, Steven, Ingo, the short version of the story is that we
>   need to make it such that the _ftrace_events section is aligned
>   properly for 64-bit systems, and in particular that GCC can see this
>   too.  Otherwise GCC thinks 64-bit words will be unaligned and we get
>   all kinds of funky relocations being used in modules on sparc64 that
>   really there is never any reason to see. ]
> 
> > They seem to come from scsi.o at
> > 
> > .LLC51:
> >         .asciz  "scsi_eh_wakeup"
> >         .section        _ftrace_events,"aw",@progbits
> >         .align 4
> >         .type   event_scsi_eh_wakeup, #object
> >         .size   event_scsi_eh_wakeup, 136
> > event_scsi_eh_wakeup:
> >         .skip   16
> >         .uaxword        event_class_scsi_eh_wakeup
> >         .uaxword        .LLC51
> >         .skip   8
> >         .skip   40
> >         .uaxword        ftrace_event_type_funcs_scsi_eh_wakeup
> >         .uaxword        print_fmt_scsi_eh_wakeup
> >         .skip   40
> 
> These ".uaxword" emissions are a bug, and if we let them stand then
> ftrace events are going to load every long word object using a
> sequence of byte-sized accesses.  This will absolutely kill
> performance.
> 
> This is exactly why I wanted to find out why this started happening
> out of nowhere, instead of blindly adding support for new relocation
> types to the sparc module loader.
> 
> The set of relocations supported by the sparc module loading code is
> not meant to be "all relocations which are legal" but rather it's
> meant to support the most minimum set of relocations that the kernel
> actually _needs_ and should be making use of.
> 
> I think the problem we have here is that the _ftrace_events section is
> not aligned sufficiently.  That ".align 4" mnemonic is a good indication
> of this.  It should at least "8" on sparc64.
> 
> So we need to figure out why that is happening, and fix that instead.
> 
> Thanks.

I'm wondering if gcc is just getting better at honouring the source
code. The DEFINE_EVENT macros in include/trace/ftrace.h have a
__aligned__(4) attribute in them. Maybe that should be 8 on sparc64
systems.
The aligned 4 seems to be unchanged since include/trace/ftrace.h was
created in f42c85e74faa422cf0bc747ed808681145448f88 in April 2009.

example

#undef DEFINE_EVENT
#define DEFINE_EVENT(template, call, proto, args)			\
									\
static struct ftrace_event_call __used					\
__attribute__((__aligned__(4)))						\
__attribute__((section("_ftrace_events"))) event_##call = {		\
	.name			= #call,				\
	.class			= &event_class_##template,		\
	.event.funcs		= &ftrace_event_type_funcs_##template,	\
	.print_fmt		= print_fmt_##template,			\
};


I haven't tried making any changes/recompiling yet because that change
will pretty much force a full recompile and that takes upwards of 12
hours on the old sparc64 box that I have. I will wait for feedback
before I try anything.

Regards

Richard

