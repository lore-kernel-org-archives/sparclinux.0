From: Meelis Roos <mroos@linux.ee>
Date: Thu, 21 Aug 2008 08:04:22 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.SOC.4.64.0808211055540.17855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> You should stick with a single well-defined kernel version, like 
> 2.6.27-rc3.  Start by seeing what happens with ohci_hub_status_data and 
> move on from there.

Ok, I chose the fresh 2.6.27-rc4 since rc3 had other problems on sparc64 
that are fixed now.

I instrumented ohci_hub_status_data and usb_hcd_poll_rh_status and on 
one boot it started looping between these two - but I forgot to turn on 
serial console logging. With logging on, I have not succeeded in 
reproducing the looping, its just hangs (and has done so 2 times).

The hang ends with
stty used greatest stack depth: 7168 bytes left
sed used greatest stack depth: 6568 bytes left
mount used greatest stack depth: 6064 bytes left
create_static_n used greatest stack depth: 256 bytes left
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
tulip0: Old style EEPROM with no media selection information.
tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
eth0: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00000000, EEPROM not present, 00:03:ba:11:b3:71, IRQ 9.
tulip1: Old style EEPROM with no media selection information.
tulip1:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
eth1: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00002000, EEPROM not present, 00:03:ba:11:b3:72, IRQ 10.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
done.
Waiting for /dev to be fully populated... usbcore: registered new device driver usb
ohci_hcd 0000:00:0a.0: OHCI Host Controller
ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
Driver 'sr' needs updating - please use bus_type methods

Maybe the stack has overflown - udev's create_static_nodes was quite 
close at least?

Othe than stack messages and backtrace selftest, the debugging options 
in kernel hacking section have not produced anything. Turned on most of 
them besides ftrace and debug-pagealloc and example code.

Sysrq-T and other Sysrq-* commands have not started to magically work 
with -rc4, so still no dump.

-- 
Meelis Roos (mroos@linux.ee)
