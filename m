From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 21 Apr 2006 04:13:19 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <20060420.211319.103974459.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0604101839350.3168@bobcat>
In-Reply-To: <Pine.LNX.4.63.0604101839350.3168@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 11 Apr 2006 19:47:21 -0700 (PDT)

> From what I can tell, the only thing which removed code in second/timer.c 
> did is a) store the current value of the tick_cmpr register in the 
> sun4u_tickcmpr variable and disable interrupts from tick_cmpr by setting 
> bit 63 in it in sun4u_init_timer(); and b) restore the tick_cmpr value 
> from the variable in close_timer(). Could you explain how the removal of 
> this code could lead to the dramatic effect if timeout not being honoured? 
> tick_cmpr register is not touched elsewhere in the code, and I would 
> naively think that it should still work on *any* machine which has a tick 
> register (which Ultra10 obviously has). Any pointers to documentation 
> would be greatly appreciated.

So here's the full analysis, thanks for the report.

First, a reminder that we can't write to the %tick register
on sun4v, and since I thought this code couldn't possibly
be doing anything I removed it.  Obviously I was wrong and
this code is needed for the timeout to work on Ultra10 as
the reports indicate.

What the old code does is disable TICK interrupts by setting bit 63 of
the %tick_cmpr register.  That's the only functional effect of this
code.  It means that TICK interrupts will no longer arrive, and since
OBP owns the trap table this means OBP is who would service the TICK
interrupt on it's trap table.

So what it seems is happening on Ultra10 is that OBP has the TICK
interrupts going, and instead of using the normal method of just
advancing the %tick_cmpr register at every interrupt to schedule the
next TICK interrupt, it decrements the value of %tick instead.

That's why getting rid of this code makes the timeout never trigger in
SILO, the %tick register never gets past a certain value, since OBP
just keeps dragging it backwards over and over at every TICK interrupt
when %tick = %tick_cmpr.

Another thing I note is that writing %tick to zero is a very bad bug
even on sun4u systems because it means that on pre-Ultra-III SMP the
%tick register of the boot processor will be unsynchronized with all
the other sibling cpus in the machine and we use that for timekeeping.

I think the thing to do is probably to restore the old code and only
remove the line which writes "0" to %tick.  I'll test that on my
Niagara to make sure it doesn't regress.

I'll post the patch after I test it out.
