From: Richard Chan <rspchan@starhub.net.sg>
Date: Sat, 19 May 2007 10:58:09 +0000
Subject: Inheriting a V215: does pci_fire.c mean this is now supported?
Message-Id: <1179572289.3247.13.camel@tristan.tancredi.dyndns.biz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi,

I may be inheriting a V215 - and was checking for supported platforms in
Sparc64. Noticed that between 2.6.21 and 2.6.22-rc1 there appeared a new
platform pci_fire.c -  I'm hoping this means that the xx5 generation
(215, w/stations 25/45) are supported, correct? (The commit log calls it

[SPARC64]: SUN4U PCI-E controller support.

but doesn't mention any hardware models.)

OpenBSD boasts of support - and calls it pyro. Well pyro = fire, no?
(See comment about Linux not supporting pyro below --> overtaken by
events??) 

BTW don't take this as an openbsd vs linux troll - I meant that the name
correspondence OpenBSD->pyro/Linux->fire is not a coincidence right?

--an extract from OpenBSD Sparc list--

"I just committed the final bits that make the Sun Fire V215 and V245
fully supported in 4.1-current.  These machines have a PCIe host
bridge, supported by the new pyro(4) driver.  Writing this driver was
the biggest challange, since Sun doesn't provide any documentation for
it.  So it took some extensive digging through the OpenSolaris code to
figure out how the hardware was supposed to work.

OpenBSD seems to be the first OS besides Solaris to support these
machines (at least I could not find any evidence in the Linux source
code that they do support the PCIe host bridge), and the first
complete open source OS that runs on them (OpenSolaris still requires
some closed source drivers to run)............."


