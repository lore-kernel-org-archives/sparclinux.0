From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sun, 12 Aug 2007 07:42:33 +0000
Subject: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm trying to add Sun4c (SS-2) support to Qemu. I'm using Linux source
as the reference, but some things are not very clear.

Specifically, how are the interrupts routed, which interrupts (ZS,
ESP, Lance, timers, floppy, cgthree) go through the interrupt
controller? How do the controller bits map to each interrupt source
and PIL? Any docs for the controller, what is the device chip ID?

I guess the MMU is similar in operation to Sun4u/v I/D TLB, is that
correct? Any CPU docs would be helpful.

There is no IOMMU, so the DMA is limited to lowest 16 megs, right?
