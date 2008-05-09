From: David Miller <davem@davemloft.net>
Date: Fri, 09 May 2008 04:21:30 +0000
Subject: Re: enabling lockdep causes boot failure on a SUN T2000
Message-Id: <20080508.212130.57169228.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48238125.7040900@email.unc.edu>
In-Reply-To: <48238125.7040900@email.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Bjoern B. Brandenburg" <bbb@email.unc.edu>
Date: Thu, 08 May 2008 21:50:06 -0400

> I figured that if the flushes are the root cause, then this should take 
> care of the problem. However, the kernel still doesn't boot.

That patch you posted is dangerous.  If the stack isn't flushed,
there will be garabage in the frame pointer slots of the stack
frame, and likely that will cause an OOPS.

Please, let me try to resolve this as I find time to do so.  I am the
only person who knows enough about all of these internals so solve the
problem at this time.
