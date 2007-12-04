From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Tue, 04 Dec 2007 20:37:57 +0000
Subject: Sun4d interrupt handling?
Message-Id: <f43fc5580712041237n5f89d583y4a5e1572b22bdbaf@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm adding Sun4d support to Qemu and I was wondering if there are any
docs for Sun4d, especially interrupt handling (SBI, BW, counters, SMP
issues, boards). Any pointers?

Looking at Linux sources, it seems that SBI handles SBus interrupts
and then BW masks all interrupt sources. Is BW CPU specific?

It looks like basic hardware (CPU+MMU, zs, esp, lance, eeprom,
counter) is already implemented in Qemu and IO-UNIT is not very
different from IOMMU.
