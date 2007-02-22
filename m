From: David Miller <davem@davemloft.net>
Date: Thu, 22 Feb 2007 11:09:55 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <20070222.030955.78715327.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Peter Jones <pjones@redhat.com>
Date: Wed, 21 Feb 2007 11:01:49 -0500

> (apologies if you get this more than once; apparently I've been having
> some email trouble)
> 
> On Mon, 2007-01-29 at 09:34 -0800, David Miller wrote:
> 
> > Another oddity is that the buffers are filled at the tail.  So, for
> > example if you have 16 characters to output, you copy them to the
> > final 16-bytes of the buffer area (right before the 2-byte count)
> > and then you write the count to be 16.
> 
> Is the buffer actually filled backwards, or merely aligned to the tail?

The first byte of your console output goes SIZE bytes before the
tail, the last byte goes at the tail.

> > The control register contains either zero (means nothing to do)
> > or another value which indicates certain events have occurred,
> > you poll this when you poll for console input.  The possible
> > values are:
> > 
> > 0	nothing
> > 1	Stop-A break sequence
> > 2	SSP hung up on us and disconnected
> > 3	Console switch to network, stop posting output bytes to SRAM
> > 4	Console switch to SRAM, resume posting output bytes to SRAM
> > 5	Console via network closed
> > 
> > Ignore values 3, 4, and 5 for now, there is a way to redirect console
> > output over the network with the SSP but we'll not support that yet.
> 
> Are 3, 4, and 5 messages from the kernel to the SSP?  If so, don't we
> want to set 4 (and wait for it to clear?) on port->startup() ?

I have no idea, sorry.  Probably they are initiated by a daemon
or similar in userspace under Solaris.  I never checked the details.


