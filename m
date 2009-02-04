From: David Miller <davem@davemloft.net>
Date: Wed, 04 Feb 2009 22:55:41 +0000
Subject: Re: NMI appears to be stuck (0->0)
Message-Id: <20090204.145541.127196801.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090204143612.GA13284@orion>
In-Reply-To: <20090204143612.GA13284@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Wed, 4 Feb 2009 17:36:12 +0300

> Is it known problem?
> It is Ultra10.
> 
> Testing NMI watchdog ...
> WARNING: CPU#0: NMI appears to be stuck (0->0)!

It's expected.  The NMI watchdog can't work on pre-UltraSPARC-III
chips because they lack a profiling counter overflow interrupt.

I'll add some checks so it doesn't even try to do the NMI watchdog
test on these cpus.
