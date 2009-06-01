From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 01 Jun 2009 07:48:07 +0000
Subject: LEON SPARC
Message-Id: <4A2387B7.6000006@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello everybody,


I work for Aeroflex Gaisler (formely Gaisler Research) which develops
the LEON SPARC V8 processor. It is a synthesizable soft core CPU written
in VHDL and used in a wide range of applications.

We are currently maintaining our own Linux kernel and distribution for
the processor but would like to contribute it into the mainline kernel.
We understand that this will require some time and work in cooperation
with the SPARC Linux community.

Some technical background information about the LEON CPU:

LEON3 is fully SPARC V8 compliant and has a standard SRMMU as well
(except we support 4 to 32 kB pages). The cache system is VIVT with
keys but can do snooping on the physical addresses. The cache is
write through and configurable in regards to number of sets, way size
and replacement algorithm.

It has a AMBA AHB/APB bus system and supports SMP. There is a rich set
of peripherals that can be added to your typical SoC system such as
10/100/1G Ethernet MAC, USB host controller (EHCI/UHCI), USB device
controller, PCI, ATA, SPI, CAN, etc.


We have received an account on kernel.org and will maintain a sparc-leon
git repository there. I guess sparc-next is the proper repository to
clone as a base for our patches?

Is there any special way that you would like us to structure our code
to fit into the current SPARC tree as painlessly as possible?

Currently our kernel sources can be downloaded here:
ftp://gaisler.com/gaisler.com/linux/linux-2.6/linux/linux-2.6.21.1-leon23-1.0.3.tar.bz2

Internally we are however at version 2.6.29 and will be setting up
an up to date git repository for you to scrutinize.


Best regards,
Kristoffer Glembo
