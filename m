From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 25 May 2007 17:03:04 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <20070525180304.2cc4dae0@the-village.bc.nu>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
	<20070525101105.GA9268@elte.hu> <4656CE39.8050800@netunix.com>
	<alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Cherwin
	R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Robert@smtp2.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Andrey@smtp2.linux-foundation.org, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Lameter <clameter@sgi.com>, de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Greg@smtp2.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Christoph@smtp2.linux-foundation.org, Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan

> Disk dumps etc are options at things like wall street. But look at the bug 
> reports, and ask yourself how many of them happen at Wall Street, and how 
> many of them would even be _relevant_ to somebody there? 

There is an additional factor - dumps contain data which variously is -
copyright third parties, protected by privacy laws, just personally
private, security sensitive (eg browser history) and so on.

The only reasons you can get dumps back in the hands of vendors is
because there are strong formal agreements controlling where they go and
what is done with them.

Diskdump (and even more so netdump) are useful in the hands of a
developer crashing their own box just like kgdb, but not in the the
normal and rational end user response of  "its broken, hit reset"

Alan
