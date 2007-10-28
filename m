From: David Miller <davem@davemloft.net>
Date: Sun, 28 Oct 2007 03:40:44 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071027.204044.193883074.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 28 Oct 2007 04:03:44 +0100

> 
> 
> 
> I think things got worse with 2.6.24...
> The machine shoots itself now, I guess by running cron jobs or so.
> 
> [29074.766486] TSTATE: 0000000011009600 TPC: 000000000042f984 TNPC: 000000000042f928 Y: 00000000    Not tainted
> [29074.884191] TPC: <sched_clock+0x0/0x30>

What kind of OOPS is this?  Please provide the kernel log messages
that appeared right before these register dumps.

Thanks.
