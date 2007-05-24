From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 24 May 2007 18:49:02 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <20070524114902.e802f327.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, Ingo Molnar <mingo@elte.hu>, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrey Borzenkov <arvidjaar@mail.ru>, David Miller <davem@d>

On Thu, 24 May 2007 10:12:14 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > BUG: at include/linux/slub_def.h:88 kmalloc_index()
> 
> I'm going to change that "BUG:" to "WARNING:". 

I think we should remove these kmalloc(0, ...) warnings prior to
the 2.6.22 release, put them back afterwards.

Actually it would be useful to have some config variable which is "false"
for production kernels (2.6.x, 2.6.x.y) and "true" for development kernels
(2.6.x-rcN).  I suspect we'd end up using this in quite a lot of places for
general developer-nags which shouldn't be exposed to users of production
kernels.

The problem with this is that on the day Linus goes from 2.6.x-rc7 to 2.6.x
we suddenly get a compile-time kernel which nobody has tested, so we'd need
to set CONFIG_DEVELOPMENT_KERNEL to false around the -rc4/5 timeframe.

I'm not sure how we could do this, apart from patching and unpatching a
config file each time.
