From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 25 May 2007 10:11:05 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <20070525101105.GA9268@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com> <Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com> <alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org> <20070524193740.GA6787@elte.hu> <alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Lameter <clameter@sgi.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Cherwin R. Nooitmeer" <cherwin@gmail.com>, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux1394-devel@lists.sourceforge.net, Stefan Richter <stefanr@s5r6.in-berlin.de>, Kristian H?gsberg <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Marcus Better <marcus@better.se>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > i very much agree that this kmalloc_index() one shouldnt be called a 
> > "BUG: ", but if you look at the majority of WARN_ON() instances they 
> > are checks for clear, serious kernel bugs.
> 
> I _still_ disagree.
> 
> There's a huge difference between "You killed my father, prepare to 
> die", and "Btw, I didn't like that, but I'll just continue".

yeah ...

> And that's the difference between BUG_ON() and WARN_ON().

how about this solution: make WARN_ON() a "WARNING: " like you suggested 
(i still agree with that in principle), but also solve the additional 
problem i'm trying to outline: make BUG_ON() _not_ crash the box [only 
if the user asks for a crash to happen in such circumstances - this can 
be a sysctl.]. Then i can change the majority of the current WARN_ON()s 
to BUG_ON()s.

Most of the WARN_ON()s i personally add (and most of the WARN_ON()s i 
see others adding) are not WARN_ON()s because "i didnt like that and 
i'll just continue", they are WARN_ON() because i want _actual feedback 
from users_.

A BUG_ON() has a (much) lower likelyhood of being reported back - for 
most users it is a "X just hung hard, there was nothing in the syslog, i 
had to switch back to the older kernel" experience, and they do not have 
a serial console to hook up (newer hardware often doesnt even have a 
serial port). With the WARN_ON()s we have a _chance_ that despite the 
seriousness of the bug, the message makes it to the syslog, until the 
system comes to a screeching halt due to side-effects of the bug.

in that sense i am part of the problem: i was adding WARN_ON()s that 
werent true 'warnings' but 'bugs'. So i'd very much like to fix that 
problem, but i'd also like to solve the (very serious and existing) 
problem of BUG_ON()s making it less likely to get bugs reported back. 

	Ingo
