From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Thu, 22 Jan 2009 08:02:09 +0000
Subject: Re: [sparc] ext3 corruption on latest mainline
Message-Id: <200901220902.09644.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <200901201917.12141.m.kozlowski@tuxland.pl>
In-Reply-To: <200901201917.12141.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > > I ended up with corrupted ext3 (see sparc.jpg) and working now to restore it.
> > 
> > Up and running again. I managed to get some more info from yesterday crash from syslog:
> 
> I've seen similar corruptions with an Intel SSD drive on an MPT Fusion
> SAS interface, which also goes through scsi like your sym case here.
> 
> But I'm pretty sure I also saw them with 2.6.28, were you able to run
> 2.6.28 cleanly?

The thing is the last time I run this sparc was somewhere in 2.6.27~2.6.28 window.
I didn't see anything like it at that time. I'll give a try to 2.6.28 but it might
be hard to trigger it as I don't know what exactly caused it. Also yesterday
the very same kernel (f3b8436a) worked under I/O load for hours just fine.
I'll leave it with 2.6.28 on it busy for a few days and see what happens.

	Mariusz
