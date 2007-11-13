From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 13 Nov 2007 18:46:22 +0000
Subject: Icedtea for Linux_sparc (was Re: [Aurora-sparc-user] Linux vs.
Message-Id: <1194979582.25279.16.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tue, 2007-11-06 at 10:12 -0500, Scot P. Floess wrote:
> Not sure as icedtea took care of whatever downloads it required...
> The only requirement I saw was the latest RH gcj with generics
> extension...  When  I installed this under Fedora 7 - its just
> downloaded and built everything it needed.

I looked into this, and there is definitely missing code.

Everything in openjdk/hotspot/src/os_cpu/linux_sparc/vm/* would need to
be written. I don't know SPARC asm, so I can't do this work.

(CCing sparclinux@vger, in the hopes that someone there might be
interested in writing this code)

~spot

