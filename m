From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 12 Apr 2006 03:26:28 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <20060411.202628.20150763.davem@davemloft.net>
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

In fact the code was a nop as far as I could tell, that's
why I removed it.

Perhaps we can put it back in, I don't know.  I'm very busy
with gdb and Mono bug fixing at the moment, so I don't have
time to look at it right now.
