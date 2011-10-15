From: David Miller <davem@davemloft.net>
Date: Sat, 15 Oct 2011 00:34:56 +0000
Subject: Re: [PATCH 03/21] sparc: drop unused Kconfig symbol
Message-Id: <20111014.203456.760074223041131268.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1318595257.6132.59.camel@x61.thuisdomein>
	<alpine.LNX.2.00.1110150111520.26030@post.netunix.com>
In-Reply-To: <alpine.LNX.2.00.1110150111520.26030@post.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: crn@netunix.com
Cc: pebolle@tiscali.nl, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: crn@netunix.com
Date: Sat, 15 Oct 2011 01:14:02 +0100 (BST)

> 
> How does this affect Javastations, ISTR that they need PCI and one
> (rare) variant has a PCI slot. ??

How about you take even the briefest look at the code and find out for
yourself?  This is what drives me crazy about the questions you tend
to ask, you never put forth any effort of investigation on your own
and just toss arbitrary questions onto the list.

Meanwhile those of us with initiative are burdoned to do the work for
you.

The config symbol is completely unreferenced anywhere, so this
change can't possibly make any functional difference whatsoever.
