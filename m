From: David Miller <davem@davemloft.net>
Date: Wed, 21 Jan 2009 21:50:29 +0000
Subject: Re: [sparc] ext3 corruption on latest mainline
Message-Id: <20090121.135029.94778665.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200901201917.12141.m.kozlowski@tuxland.pl>
In-Reply-To: <200901201917.12141.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Wed, 21 Jan 2009 11:44:12 +0100

> > I ended up with corrupted ext3 (see sparc.jpg) and working now to restore it.
> 
> Up and running again. I managed to get some more info from yesterday crash from syslog:

I've seen similar corruptions with an Intel SSD drive on an MPT Fusion
SAS interface, which also goes through scsi like your sym case here.

But I'm pretty sure I also saw them with 2.6.28, were you able to run
2.6.28 cleanly?
