From: David Miller <davem@davemloft.net>
Date: Fri, 25 May 2007 20:36:53 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <20070525.133653.57156321.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4656CE39.8050800@netunix.com>
	<alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
	<46572507.6010800@netunix.com>
In-Reply-To: <46572507.6010800@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: crn@netunix.com
Cc: torvalds@linux-foundation.org, mingo@elte.hu, clameter@sgi.com, michal.k.k.piotrowski@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, cherwin@gmail.com, linux-pcmcia@lists.infradead.org, robert.de.rooy@gmail.com, alan@redhat.com, htejun@gmail.com, sparclinux@vger.kernel.org, mikpe@it.uu.se, linux1394-devel@lists.sourceforge.net, stefanr@s5r6.in-berlin.de, krh@bitplanet.net, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, pavel@ucw.cz, marcus@better.se, arvidjaar@mail.ru, linux-usb-devel@lists.sourceforge.net, gregkh@suse.de

From: Chris Newport <crn@netunix.com>
Date: Fri, 25 May 2007 19:03:51 +0100

> Not really a Solaris feature. This is a feature of the  Openboot  PROM
> which is also used by several other vendors.
> The Openboot PROM knows how to write to disk. The same should
> apply on Apple hardware and others which use the openboot
> convention.

This is totally unusable even if it weren't stupid, and as
someone who loves OpenBoot I think it's very stupid.

The reason it's unusable is that PowerPC already and sparc64 soon (in
order to support LDOMs) totally drops the OBP firmware very soon after
early kernel boot.  We pull in the device tree and then say "see ya"
to openboot.

PowerPC does it because sharing the address space with openboot is
next to impossible on that cpu, sparc64 will need to do it because
dynamic-reconfiguration of cpus in an LDOM is too hard to do with
openboot there.
