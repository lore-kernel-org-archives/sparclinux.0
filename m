From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 24 May 2007 17:18:55 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <Pine.LNX.4.64.0705241017010.29041@schroedinger.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
 <Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
 <alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Cherwin R. Nooitmeer" <cherwin@gmail.com>, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux1394-devel@lists.sourceforge.net, Stefan Richter <stefanr@s5r6.in-berlin.de>, =?iso-8859-15?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Marcus Better <marcus@better.se>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>, Ingo Molnar <mingo@elte.hu>

On Thu, 24 May 2007, Linus Torvalds wrote:

> I'm going to change that "BUG:" to "WARNING:". 

Good. I wondered for a long time why a "WARN_xxx ... " does print BUG: 
xxx.
