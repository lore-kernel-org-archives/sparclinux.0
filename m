From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 20:11:43 +0000
Subject: Re: Oops while shutdown on serial console
Message-Id: <20051010.131143.121854311.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <diech22mm0@ds9.argh.org>
In-Reply-To: <diech22mm0@ds9.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sven Hartge <hartge@ds9.argh.org>
Date: Mon, 10 Oct 2005 20:44:42 +0200 (CEST)

> Is this Oops specific to all sparc64 systems or does it just happen on 
> sbus ones?

Specific to all sparc systems using serial console, it's some
problem in either the UART layer or the sparc serial drivers.

> The same question applies to the bug I sent the patch earlier, 

Specific to sparc64 systems using iptables and having discontiguous
physical cpu numbers.

> I am asking, because I have some E150 and E250, which I would like to 
> convert from SunOS 2.6 to Linux, but I am dependant on proper serial 
> console support.

I'll try to fix the serial problem this week.
