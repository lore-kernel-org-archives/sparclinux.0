From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2007 16:21:03 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <alpine.LFD.0.98.0705250920300.26602@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
	<20070525101105.GA9268@elte.hu> <4656B7DF.6020005@s5r6.in-berlin.de>
In-Reply-To: <4656B7DF.6020005@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Ingo Molnar <mingo@elte.hu>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, David Miller <davem@davemloft.net>



On Fri, 25 May 2007, Stefan Richter wrote:

> Ingo Molnar wrote:
> > i was adding WARN_ON()s that werent true 'warnings' but 'bugs'.
> 
> IME, the trace dump in the kernel log looks scary enough to be
> eventually reported, even if prefixed with "WARNING:".

Oh, absolutely. It will stand out like a sore thumb. In fact, I think 
WARNING: stands out more than BUG:, if only because it's longer!

		Linus
