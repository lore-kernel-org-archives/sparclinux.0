From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 May 2007 17:12:14 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Christoph Lameter <clameter@sgi.com>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, =?iso-8859-15?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, Ingo Molnar <mingo@elte.hu>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>David Miller <d>



On Thu, 24 May 2007, Christoph Lameter wrote:
>
> On Thu, 24 May 2007, Michal Piotrowski wrote:
>=20
> > Memory management
> >=20
> > Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=8476
> > Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
> > Status     : Unknown
>=20
>=20
> Looks like this is in DRM code:
>=20
> BUG: at include/linux/slub_def.h:88 kmalloc_index()

I'm going to change that "BUG:" to "WARNING:".=20

I know some people disagreed with it (ie Ingo), but I think that's total=20
and utter bullshit.

It's a warning. Right now that "BUG:" message makes people all scared=20
about something that is not fatal at all, just a note that something=20
hasn't been converted, but is expected to work absolutely fine.

Calling it a bug is idiotic.

			Linus
