From: Ben Collins <bcollins@debian.org>
Date: Wed, 07 Apr 2004 19:17:13 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <20040407191713.GZ1947@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> kbd_init: Assuming USB keyboard.

> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> host/usb-uhci.c: $Revision: 1.275 $ time 15:49:35 Nov 29 2003
> host/usb-uhci.c: High bandwidth mode enabled
> host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> host/usb-ohci.c: USB OHCI at membase 0x7fe01000000, IRQ 9,21f
> host/usb-ohci.c: usb-00:05.3, PCI device 108e:1103
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 4 ports detected
> usb.c: registered new driver hid
> hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers

Is it a USB keyboard? If it is, it isn't getting detected.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
