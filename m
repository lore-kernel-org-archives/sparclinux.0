From: Paul Thomas <pthomas8589@gmail.com>
Date: Wed, 25 Mar 2009 16:09:29 +0000
Subject: configs
Message-Id: <c785bba30903250909y5c742607sc32a26ab06b87350@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I'm new to the sparc architecture (I'm used to arm), I don't even have
any sparc hardware yet. But I'm curious enough about the opensparc
processors that I pulled the sparc-2.6 git tree. First I did a "make
ARCH=sparc sparc64_defconfig" and then "make ARCH=sparc xconfig". This
all works fine, but I'm confused about how the configurations work. In
the arm branch there is both selection of the "ARM system type" and a
specific board selection after that. I guess the sparc processors are
different in that they don't have all of the peripherals that arm
processors have.

So my question is, what are the configuration options for the 3 main
features (memory controller, pcie & XAUI) of the T2 processor. The
only memory controller I see is the "UltraSPARC-III Memory Controller
driver" is that the same for the T2? I don't see any pcie
configuration options, but there is the drivers/pci/pcie directory. Is
the pcie driver built-in by default? In the "Ethernet (10000 Mbit)"
section the Sun Neptune is checked, but it looks like the Neptune is a
standalone pcie card. Is that the driver for the XAUI interfaces on
the T2?

thanks,
Paul
