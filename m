From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Mon, 08 Aug 2016 22:49:40 +0000
Subject: Re: [PATCH v15 04/10] arm64: Kprobes with single stepping support
Message-Id: <20160809074940.1f33751bc1e6f81b8ee69d44@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <57969234.1070201@linaro.org>
 <22b277ba-6812-a0dd-9e8e-c29bdb3aa672@linaro.org>
 <57993211.1040600@linaro.org>
 <20160728144053.GA26510@e104818-lin.cambridge.arm.com>
 <360d582b-5401-7126-ef40-bd78369c0a34@linaro.org>
 <57A2C8DF.7050401@linaro.org>
 <74b8c503-b6df-dcb1-c278-d49850fe3715@linaro.org>
 <57A89731.20709@linaro.org>
In-Reply-To: <57A89731.20709@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 8 Aug 2016 10:29:05 -0400
David Long <dave.long@linaro.org> wrote:

> >> @@ -489,20 +477,15 @@ int __kprobes setjmp_pre_handler(struct kprobe
> >> *p, struct pt_regs *regs)
> >>  {
> >>      struct jprobe *jp = container_of(p, struct jprobe, kp);
> >>      struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> >> -    long stack_ptr = kernel_stack_pointer(regs);
> >>
> >>      kcb->jprobe_saved_regs = *regs;
> >>      /*
> >> -     * As Linus pointed out, gcc assumes that the callee
> >> -     * owns the argument space and could overwrite it, e.g.
> >> -     * tailcall optimization. So, to be absolutely safe
> >> -     * we also save and restore enough stack bytes to cover
> >> -     * the argument area.
> >> +     * Since we can't be sure where in the stack frame "stacked"
> >> +     * pass-by-value arguments are stored we just don't try to
> >> +     * duplicate any of the stack.
> >  > ...
> >>                                       Do not use jprobes on functions
> >> that
> >> +     * use more than 64 bytes (after padding each to an 8 byte boundary)
> >> +     * of arguments, or pass individual arguments larger than 16 bytes.
> >
> > I like this wording. So much so that it really would be great to repeat
> > this in the Documentation/. Could this be included in the list of
> > architecture support/restrictions?
> >
> 
> Are you thinking specifically of the "5. Kprobes Features and 
> Limitations" section in Documentation/kprobes.txt?

OK, That's a good idea :)

If you update the patch for that, please feel free to add my Ack.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
