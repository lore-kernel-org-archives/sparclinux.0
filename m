From: Robert Reif <reif@earthlink.net>
Date: Sun, 14 Sep 2008 23:51:56 +0000
Subject: Re: [PATCH]: Updated PROM sun4m IRQ register patch.
Message-Id: <48CDA39C.4060606@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080913.214526.47086017.davem@davemloft.net>
In-Reply-To: <20080913.214526.47086017.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> I just tried SMP and I got a Watchdog Reset.  I'll back this one out 
> and see if the first one works SMP.
I tried physically removing one CPU and I still get a Watchdog Reset so 
it is not dependent on the number of CPUs.
