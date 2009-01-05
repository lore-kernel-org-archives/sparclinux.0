From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 05 Jan 2009 19:31:34 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org>
In-Reply-To: <20090105181922.GA25622@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>


On Mon, 5 Jan 2009, Sam Ravnborg wrote:

> With an allmodconfig build on sparc and sparc64 I started
> to see warnings that become propagated to errors by -Werror.
> 
> Example:
>   CC      arch/sparc/kernel/ldc.o
> arch/sparc/kernel/ldc.c: In function `process_control_frame':
> arch/sparc/kernel/ldc.c:627: warning: 'vap' might be used uninitialized in this function
> 
> 
> The code in question looks like this:
> static int process_ver_nack(struct ldc_channel *lp, struct ldc_version *vp)
> {
>         struct ldc_version *vap;
> 
>         if ((vp->major = 0 && vp->minor = 0) ||
>             !(vap = find_by_major(vp->major))) {
>                 return ldc_abort(lp);
>         } else {
>                 struct ldc_packet *p;
>                 unsigned long new_tail;
> 
>                 p = handshake_compose_ctrl(lp, LDC_INFO, LDC_VERS,
>                                            vap, sizeof(*vap),
>                                            &new_tail);
>                 if (p)
>                         return send_tx_packet(lp, p, new_tail);
>                 else
>                         return ldc_abort(lp);
>         }
> }
> 
> The else part will never be executed whitout assigning vap,
> and this code do not emit warnings in the normal case.
> [I am well aware that we recommend to move the assignment
> out of the if () - but this code worked as is before].
> 
> This code gets expanded to:
> 
> static int process_ver_nack(struct ldc_channel *lp, struct ldc_version *vp)
> {
> 	struct ldc_version *vap;
> 
> 	if (__builtin_constant_p(((vp->major = 0 && vp->minor = 0) || !(vap = find_by_major(vp->major)))) ? 
> 	!!((vp->major = 0 && vp->minor = 0) || !(vap = find_by_major(vp->major))) : 
> 	({
> 		int ______r;
> 		static struct ftrace_branch_data  ______f = { .func = __func__, .file = "arch/sparc/kernel/ldc.c", .line = 630, };
> 		______r = !!((vp->major = 0 && vp->minor = 0) || !(vap = find_by_major(vp->major)));
> 		if (______r)
> 			______f.hit++;
> 		else
> 			______f.miss++; ______r;
> 	})) {
> 
> 		return ldc_abort(lp);
> 	} else {
> 		struct ldc_packet *p;
> 		unsigned long new_tail;
> 
> 		p = handshake_compose_ctrl(lp, 0x01, 0x01, vap, sizeof(*vap), &new_tail);
> 		if (__builtin_constant_p((p)) ? !!(p) : ({
> 			int ______r;
> 			static struct ftrace_branch_data ______f = { .func = __func__, .file = "arch/sparc/kernel/ldc.c", .line = 639, };
> 			______r = !!(p);
> 			if (______r)
> 				______f.hit++;
> 			else ______f.miss++;
> 				______r;
> 		}))
> 	 		return send_tx_packet(lp, p, new_tail);
> 		else
> 			return ldc_abort(lp);
> 	}
> }
> I have inserted newlines + tabs and removed a few __attribute__()
> to keep line lengths to a sensible level.
> 
> My head started to spin with a dangerous speed trying to figure out
> the code snippet above.

My head spun a little by figuring out that vap is initialized in 
the original code.

Honestly, that code is a little obfuscated, and would be better to write 
it as:

	if (vp->major = 0 && vp->minor=0)
		return ldc_abort(lp);

	vap = find_by_major(vp->major);
	if (!vap)
		return ldc_abort(lp);

	[...]

This is much easier to read and we can remove the else statement 
altogether. And I bet the warning will go away if we did it this way.

-- Steve


> 
> On top of this some inlining occurs which is why gcc point at another
> function name.
> 
> 
> This is with following gcc version:
> 
> sparc64-unknown-linux-gnu-gcc (GCC) 3.4.5
> Copyright (C) 2004 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> Build using crosstool.
> 
> Is this a known issue?
> 
> Any recommendations?
> 
> 	Sam
> 
> 
