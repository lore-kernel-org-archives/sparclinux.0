From: Leen Besselink <leen@consolejunkie.net>
Date: Fri, 13 Apr 2007 10:27:32 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070413102730.GA29335@pagelink.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

A few days ago, I sent an e-mail to you personally about the ESP driver.

I now have a more complete bug-report for the old driver.

The old driver now runs on my old sparcstation 4, the workaround was to
disable SCSI-multilun.

Strange thing is, 2.4.x also recognizes the ESP-SCSI-part of the extra SBUS-card
I have installed (combined UTP & SCSI-card of which I can't remember the name/model
right now). 2.6.x did not recognizes the second controller.

Not that it matters much to me personally, I only have a single SCSI-disk on the
onboard-controller.

I will test the new driver for you I think.

As you did not mention a minimal kernel version that has all the required versions
of the used subsystems, I'm guessing 2.6.20.5 is ok to test it with ?

First I'll start with SCSI-multilun disabled again and work 'up' from there
- my function description at work says programmer, so I like to think I know a bit
what to look for.

I'm not that worried about my filesystem, a quick rsync will probably help
to keep a good backup of the data that I don't really need all that much.

I'm guessing I don't need the other bug-fix, as it's for sparc64.

I hope to send you a thumbs up or bug report today.

Have a nice day,
	Leen Besselink.

PS Sorry for all the me, me, me in this e-mail. ;-)

_____________________________________
New things are always on the horizon.
