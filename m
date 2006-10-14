From: David Miller <davem@davemloft.net>
Date: Sat, 14 Oct 2006 23:54:53 +0000
Subject: Re: Problematic simba PCI bridge code in xorg
Message-Id: <20061014.165453.72713975.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061014164325.GA4374@droopy.oc.cox.net>
In-Reply-To: <20061014164325.GA4374@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 14 Oct 2006 09:43:25 -0700

> Recently we've got a report of xorg crashing on an Ultra10 box, and=20
> corrupting the filesystem in the process. After some investigation I=20
> found the bug 8020 which you've filed against xorg at
>=20
> https://bugs.freedesktop.org/show_bug.cgi?id=8020
>=20
> That looked like it could be the reason for the crash, as the box in=20
> question has this simba PCI bridge. So I disabled the call to the=20
> sparcPciPciBridge function, by not defining ARCH_PCI_PCI_BRIDGE in=20
> hw/xfree86/os-support/bus/Pci.h and rebuilt it. The resulting server=20
> worked fine both on my Ultra5 (it has simba bridge in it, but it has=20
> worked even before the change) and Ultra10, which was crashing before.=20
> The problem seems to be solved, however I feel a bit uneasy about=20
> removing the code without understading the possible impact. Are there=20
> any possible negative consequences for such a removal? If the code is=20
> not useful, why is it still in xorg anyway?

That code was the code author's poor attempt to add VGA routing
support for SIMBA based sparc boxes.

Unless you're doing some weird multi-head setup, you won't notice
if that code is removed.  And since it makes the box crash, the
code is totally pointless.

I disabled it in order to get my ultra5 and ultra10 working.

It's amazing that an obvious disk-eater bug with a proposed solution
sits in the XORG bug database for months.
