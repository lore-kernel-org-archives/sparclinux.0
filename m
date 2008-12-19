From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Fri, 19 Dec 2008 16:37:15 +0000
Subject: Re: [PATCH-2.6.28 final] byteorder: fix new headers for userspace
Message-Id: <1229704635.32291.5.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
References: <4943DAD6.7070402@gentoo.org>
	 <20081216.011334.124918024.davem@davemloft.net>
	 <1229564779.6481.26.camel@brick>
	 <alpine.LFD.2.00.0812181208070.14014@localhost.localdomain>
	 <alpine.LFD.2.00.0812181246420.14014@localhost.localdomain>
	 <20081219090856.48666b14@infradead.org>
In-Reply-To: <20081219090856.48666b14@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arjan van de Ven <arjan@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, bluebird@gentoo.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

On Fri, 2008-12-19 at 09:08 +0100, Arjan van de Ven wrote:
> On Thu, 18 Dec 2008 12:47:28 -0800 (PST)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > 
> > 
> > On Thu, 18 Dec 2008, Linus Torvalds wrote:
> > > 
> > > I think it would be better to just make it a config option, call it 
> > > CONFIG_[LITTLE|BIG]_ENDIAN and set it up in the architecture
> > > Kconfig file. I think some of the people who can set it dynamically
> > > (or where it depends on the target machine) already effectively do
> > > that.
> > 
> > Never mind, since we end up having to export it to user space (do
> > we?) we can't depend on the config.h file, nor can we pollute the
> > name space.
> > 
> 
> why are we exposing byte order functions to userspace in the first
> place ????
> 

Hysterical raisons.  When I originally consolidated the byteorder stuff
I removed the userspace export.  HPA (CC'd) made the point that this
API (rightly or wrongly) was currently exported and used by userspace
and we shouldn't pull the rug out from under them.

I would have liked to un-export it, then we could also make linux/byteorder.h
the preferred include instead of asm/ ... but we appear to be stuck with
historical baggage here.

Crazy idea: could a byteorder-user.h be added that make headers-export
will pick up instead of byteorder.h that the kernel _actually_ uses?

Then we could keep exporting _something_ to avoid breaking userspace
and allow the version the kernel actually uses to be evolved a bit
more easily?

Harvey

