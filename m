From: David Miller <davem@davemloft.net>
Date: Thu, 12 Apr 2007 05:06:22 +0000
Subject: Re: parport_sunbpp patch, works on ultra2
Message-Id: <20070411.220622.85396261.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <op.tqnalwnm3zd5kp@k37>
In-Reply-To: <op.tqnalwnm3zd5kp@k37>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Arkadi Shishlov" <arkadi@mebius.lv>
Date: Thu, 12 Apr 2007 03:35:46 +0300

> With 2.6(.20) parport_sunbpp parallel port driver the printing on Ultra2 is
> impossible. Most of the characters sent to /dev/lp0 are lost.
> The following patch works for me with LPRNG and CUPS, lpr and Windows client
> via Samba. I can print test pages from CUPS and Windows, documents with tables.
> The printer is very misbehaving HP DeskJet.
> Perhaps the code is in wrong place and generic parport infrastructure should be
> revisited instead for correct operation of polling. It will fill syslog with
> "timeout waiting" at first opportunity. And such amount of udelay()-s is awfull.
> Credits for algorith goes to OpenBSD bpp driver author.
> Plese CC me, I'm not on list.

Thanks for posting this patch, I'll have a look at it
soon.
