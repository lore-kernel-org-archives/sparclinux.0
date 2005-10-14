From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 14 Oct 2005 22:35:38 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <20051014.153538.101724836.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 12 Oct 2005 12:28:17 +0300 (EEST)

> Is this known to corrupt sometimes or is it thought to be fixed?
> I'm running todays 2.6.14-rc4-gda64c6ee.

It's known, and unfortunate.

I tried everything to correct this problem, but to no avail.  The
current 2.6.x sunsab driver even defers all parameter changing in the
chip until the transmitter is %100 idle.  That still doesn't help,
as your trace shows.

I'll have to dig into init and see what kind of terminal setting
calls it does.

Thanks for the reminder about this problem.
