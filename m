From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 03 Aug 2014 12:25:35 +0000
Subject: Re: [PATCH] Fix BREAK handling in sunsab serial driver
Message-Id: <201408031425.35800.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271519.22272.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271519.22272.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 29 July 2014 00:54, David Miller wrote:
> From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
> Date: Sun, 27 Jul 2014 15:19:21 +0200
> 
> > However, there seems to be another problem that causes an Oops when
> > a register dump is requested by SysRq. This is caused when
> > perf_event_print_debug() is called from sysrq_handle_showregs() in
> > drivers/tty/sysrq.c.
> 
> Did you save the OOPS?  It should be trivial to debug with that
> information.

We had a serial console attached to the SunBlade during debugging and
development of the patches, and serial output was logged to a file. I
think we should therefore have captured the OOPS.

Norman Beck (in CC) should be able to extract the OOPS from this log
and send it to you. (I do not have access to this SunBlade anymore
since July.)

> perf_event_print_debug() doesn't do anything fancy, it disables CPU
> interrupts and reads the PCR and PIC registers.
> 
> UltraSPARC-III should be using direct_pcr_ops for this, therefore:
> 
> 	__asm__ __volatile__("rd %%pcr, %0" : "=r" (val));
> 
> and
> 
> 	__asm__ __volatile__("rd %%pic, %0" : "=r" (val));
> 
> are the two operations it will perform.

IIRC it was a null pointer dereference in perf_event_print_debug(),
but I am not quite sure, as we quickly disabled this call to continue
working (getting BREAK on the serial console to work was top priority
then). We will have to wait for Norman to retrieve this information -
he is currently on vacation, however, so it will take another week.

Regards,
Alexander Schulze
