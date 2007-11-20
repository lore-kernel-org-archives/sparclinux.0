From: David Miller <davem@davemloft.net>
Date: Tue, 20 Nov 2007 05:44:05 +0000
Subject: Re: Icedtea for Linux_sparc
Message-Id: <20071119.214405.251658582.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 13 Nov 2007 13:46:22 -0500

> 
> On Tue, 2007-11-06 at 10:12 -0500, Scot P. Floess wrote:
> > Not sure as icedtea took care of whatever downloads it required...
> > The only requirement I saw was the latest RH gcj with generics
> > extension...  When  I installed this under Fedora 7 - its just
> > downloaded and built everything it needed.
> 
> I looked into this, and there is definitely missing code.
> 
> Everything in openjdk/hotspot/src/os_cpu/linux_sparc/vm/* would need to
> be written. I don't know SPARC asm, so I can't do this work.
> 
> (CCing sparclinux@vger, in the hopes that someone there might be
> interested in writing this code)

I'll see if I can devote some cycles to this when I get back from
my trip to Korea.

I had looked briefly at this earlier and I have a decent idea of
what's involved, in fact the most difficult part is getting a
build going, the number of dependencies is just rediculious.

