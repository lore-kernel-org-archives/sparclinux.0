From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jun 2014 06:19:04 +0000
Subject: Re: Linux 3.15: SPARC serial console regression
Message-Id: <20140617.231904.4918050259821316.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140610192438.GA6846@ravnborg.org>
	<53977688.5080802@hurleysoftware.com>
	<20140615185635.GA22577@ravnborg.org>
In-Reply-To: <20140615185635.GA22577@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: peter@hurleysoftware.com, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, sethb@digi.com, LinusTorvaldstorvalds@linux-foundation.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 15 Jun 2014 20:56:35 +0200

> This is a regression so we should either revert the above commit
> or review and fix the remaining drivers.

I plan to review and integrate the sparc serial driver fixes
soon.
