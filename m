From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 May 2007 16:33:54 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <20070525093354.5dbe5f43.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
	<20070525101105.GA9268@elte.hu> <4656CE39.8050800@netunix.com>
	<20070525123456.GA17238@elte.hu>
In-Reply-To: <20070525123456.GA17238@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Andrey@smtp2.linux-foundation.org, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Greg@smtp2.linux-foundation.org, Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Chris Newport <crn@netunix.com>

On Fri, 25 May 2007 14:34:56 +0200 Ingo Molnar <mingo@elte.hu> wrote:

> * Chris Newport <crn@netunix.com> wrote:
> 
> > There is a fundamental problem in getting a decent log to debug a 
> > crashed kernel.  Maybe we should take a hint from Solaris. If the 
> > kernel crashes Solaris dumps core to swap and sets a flag. At the next 
> > boot this image is copied to /var/adm/crashdump where it is preserved 
> > for future debugging. Obviously swap needs to be larger than core, but 
> > this is usually the case.
> 
> we've got kdump, but it's not usually enabled by default by distros.

Isn't that awful?

By now we should be in the situation where if a tester is hitting a
kernel crash we can say to them "please turn on crashdumps and send me
the image".  But we're not - kernel developers don't know how to turn the
thing on in $RANDOM_DISTRO, testers have no experience with the feature
and kernel developers don't have experience handling the crash images.

And I'm not sure that the (required) "don't dump user memory and pagecache"
feature has been implemented yet?

It'd be in our interests to push all this along a bit.
