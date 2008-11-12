From: David Miller <davem@davemloft.net>
Date: Wed, 12 Nov 2008 00:15:09 +0000
Subject: Re: 2.6.28-rc4: BUG: spinlock lockup on CPU#0
Message-Id: <20081111.161509.104851175.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081111233230.GC12456@orion>
	<20081111.154902.11426409.davem@davemloft.net>
	<a4423d670811111609l37dcfe6bme277692b5206b5ec@mail.gmail.com>
In-Reply-To: <a4423d670811111609l37dcfe6bme277692b5206b5ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, kernel-testers@vger.kernel.org, rjw@sisk.pl

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Wed, 12 Nov 2008 03:09:54 +0300

> 2008/11/12 David Miller <davem@davemloft.net>:
> > From: Alexander Beregalov <a.beregalov@gmail.com>
> > Date: Wed, 12 Nov 2008 02:32:30 +0300
> >
> >> It is on sparc64 (Ultra 10). 2.6.28-rc4-00011-g3ad4f59
> >>
> >> BUG: spinlock lockup on CPU#0, metalog/1322, 00000000007f1430
> >> Kernel panic - not syncing: Aiee, killing interrupt handler!
> >>
> >> It seems Sysrq does not work.
> >>
> >> David, how can I provide more info before I reboot it ?
> >>
> >> Full dmesg:
> >
> > Hmm, this BUG message should have given you a register dump and a
> > backtrace.
> >
> > Can you give it a "Alt-SysRQ-p" and show the output?
> No, sysrq does not work, even Stop-A does not work now.
> How could it be.

The cpu stuck on the spinlock has interrupts disabled, but this
is the cpu that services console interrupts.

That's how it could be.
