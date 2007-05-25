From: Christoph Lameter <clameter@sgi.com>
Date: Fri, 25 May 2007 16:45:04 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <Pine.LNX.4.64.0705250939210.6292@schroedinger.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
 <Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
 <alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
 <20070524193740.GA6787@elte.hu> <alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
 <20070525101105.GA9268@elte.hu> <4656CE39.8050800@netunix.com>
 <20070525123456.GA17238@elte.hu> <20070525093354.5dbe5f43.akpm@linux-foundation.org>
In-Reply-To: <20070525093354.5dbe5f43.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Newport <crn@netunix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "Cherwin R. Nooitmeer" <cherwin@gmail.com>, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux1394-devel@lists.sourceforge.net, Stefan Richter <stefanr@s5r6.in-berlin.de>, Kristian H?gsberg <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Marcus Better <marcus@better.se>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>, jlan@sgi.com

On Fri, 25 May 2007, Andrew Morton wrote:

> the image".  But we're not - kernel developers don't know how to turn the
> thing on in $RANDOM_DISTRO, testers have no experience with the feature
> and kernel developers don't have experience handling the crash images.

Well, we for instance have problems with huge crash dumps. Its even a 
challenge if the machine has only a few gigabytes of main memory.
 
> And I'm not sure that the (required) "don't dump user memory and pagecache"
> feature has been implemented yet?

A colleague of mine is still working to get it to work just right on IA64.
He does it full time. sigh. Jay what is the status on that?

