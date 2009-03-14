From: Chris Torek <chris.torek@windriver.com>
Date: Sat, 14 Mar 2009 22:24:41 +0000
Subject: Re: question on sparc64 switch_to macro
Message-Id: <200903142224.n2EMOfn13773@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903141853.n2EIrqn13598@elf.torek.net>
In-Reply-To: <200903141853.n2EIrqn13598@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>"rd %pc, X" doesn't schedule very well at all, it flushes the pipeline
>completely and cannot issue alongside other instructions.

Oh, in that case maybe the other code that does the "rd %pc" version
should be switched to using sethi/or sequences.  (Or maybe it is
already in places where there is no good scheduling.)

>I'm pretty sure using a software interrupt is the best solution.

OK.

>It's so easy to reschedule this kgdb capture thing into a software
>interrupt, please code that up and give it a whirl.
>
>Or, as usual, I'll do it :-/

Heh.  In my case, I will have to go work out how the software
interrupts work, so as to make sure I don't step on some other
interrupt.

I'll probably get a chance to try sometime Monday or Tuesday though --
actually I'm working with other folks and they'd be doing the "try"
part -- as I have a pile of other work I have to get done this
weekend and Monday.

Chris
