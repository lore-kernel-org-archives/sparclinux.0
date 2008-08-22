From: Meelis Roos <mroos@ut.ee>
Date: Fri, 22 Aug 2008 09:08:34 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808221206260.15176@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> At first glance there's nothing wrong.  But looking more closely, it's 
> obvious that the time values are extremely peculiar.
> 
> For example, look at the time difference between the "start" line and
> the "uses_new_polling" line.  Those are practically adjacent in your
> code, right?  How could there possibly be a gap of 50 ms between the
> two?  Your CPU isn't running at a clock speed of 0.1 MHz, is it?  
> Could something be monopolizing the PCI or memory bus beyond all
> reasonable bounds?

I removed my debugging printks, leaving just the patch applied, and 
retried.

First time it hung in pata_ali startup again.

Second time it got to the ohci code and hung there:

INIT: version 2.86 booting
[  189.928665] stty used greatest stack depth: 7168 bytes left
[  190.257075] sed used greatest stack depth: 6848 bytes left
[  190.807869] mount used greatest stack depth: 6064 bytes left
[  191.776332] create_static_n used greatest stack depth: 256 bytes left
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...[  193.942211] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[  194.025772] tulip0: Old style EEPROM with no media selection information.
[  194.115454] tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
[  194.224245] eth0: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00000000, EEPROM not present, 00:03:ba:11:b3:71, IRQ 9.
[  194.366338] tulip1: Old style EEPROM with no media selection information.
[  194.455951] tulip1:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
[  194.564896] eth1: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00002000, EEPROM not present, 00:03:ba:11:b3:72, IRQ 10.
[  194.976710] usbcore: registered new interface driver usbfs
[  195.049993] usbcore: registered new interface driver hub
done.
Waiting for /dev to be fully populated...[  195.775399] usbcore: registered new device driver usb
[  195.947472] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[  196.045977] ohci_hcd: block sizes: ed 80 td 96
[  196.104943] PCI: Enabling device: (0000:00:0a.0), cmd 2
[  196.173726] ohci_hcd 0000:00:0a.0: OHCI Host Controller
[  196.244556] drivers/usb/core/inode.c: creating file 'devices'
[  196.320447] drivers/usb/core/inode.c: creating file '001'
[  196.391873] ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
[  196.489734] ohci_hcd 0000:00:0a.0: created debug files
[  196.557562] ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
[  196.683692] Driver 'sr' needs updating - please use bus_type methods


-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
