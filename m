From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 May 2007 19:50:22 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
In-Reply-To: <20070524193740.GA6787@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, David Miller <dave>



On Thu, 24 May 2007, Ingo Molnar wrote:
> 
> i very much agree that this kmalloc_index() one shouldnt be called a 
> "BUG: ", but if you look at the majority of WARN_ON() instances they are 
> checks for clear, serious kernel bugs.

I _still_ disagree.

There's a huge difference between "You killed my father, prepare to die", 
and "Btw, I didn't like that, but I'll just continue".

And that's the difference between BUG_ON() and WARN_ON().

And dammit, the kernel message should make that CLEAR. It's totally 
idiotic to call both "BUG". One is a clear BUG, the other is a "uhhuh, 
something unexpected happened, but I know how to continue".

So stop this idiotic "we should call them both the same". If they actually 
were the same, they'd both be called BUG_ON().

		Linus
