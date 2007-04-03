From: Meelis Roos <mroos@linux.ee>
Date: Tue, 03 Apr 2007 08:56:24 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.98 (Beta 1 for 3.0)
Message-Id: <20070403085624.1293414782@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <1175577171.3531.131.camel@localhost.localdomain>
In-Reply-To: <1175577171.3531.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

TsC> - Most IDE based SPARC systems need to boot with ide=nodma.
TsC> Specifically, Ultra 5/10 and Sun Blade 100s need this for sure.

FWIW: I am running my Ultra 5 with a 120G WD IDE drive as the only disk drive
for a long time with weekly git-snapshot kernel and have seen zero problems for
a long time. Using DMA of course. Gcc has been what was in Debian unstable at
any point, currently 4.1. I just testbooted Debian's 2.6.18-4 kernel and it
works fine too:

CMD646: IDE controller at PCI slot 0000:01:03.0
CMD646: chipset revision 3
CMD646: chipset revision 0x03, MultiWord DMA Force Limited
CMD646: 100% native mode on irq 14
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC WD1200JB-75CRA0, ATA DISK drive
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14
Probing IDE interface ide1...
hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 14 (shared with ide0)
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 234375000 sectors (120000 MB)
        native  capacity is 234441648 sectors (120034 MB)
hda: Host Protected Area disabled.
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHSe535/16/63, (U)DMA
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: ATAPI 32X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20

-- 
Meelis Roos
