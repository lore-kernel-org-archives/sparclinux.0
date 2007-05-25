From: Alan Cox <alan@redhat.com>
Date: Fri, 25 May 2007 17:48:25 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <20070525174825.GA10269@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
	<20070525101105.GA9268@elte.hu> <4656CE39.8050800@netunix.com>
	<alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
	<20070525180304.2cc4dae0@the-village.bc.nu>
	<alpine.LFD.0.98.0705251012200.26602@woody.linux-foundation.org>
	<20070525103714.092ad631.akpm@linux-foundation.org>
In-Reply-To: <20070525103714.092ad631.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Ingo Molnar <mingo@elte.hu>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Chris Newport <crn@netunix.com>, Andrey

On Fri, May 25, 2007 at 10:37:14AM -0700, Andrew Morton wrote:
> Often we don't even get that: "I was in X and it didn't hit the logs".

Thats mostly solved by fixing the Oops and framebuffer code to co-operate
and is a different problem

Alan

