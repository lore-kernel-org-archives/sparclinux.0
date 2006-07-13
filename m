From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jul 2006 20:17:29 +0000
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
Message-Id: <20060713.131729.115909938.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
In-Reply-To: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 13 Jul 2006 14:18:33 +0200 (MEST)

> Confirmed. With this patch my Ultra5 boots fine again. Thanks.

Thanks for testing.

> (I still need that patch to repair PCI mmap() for X11, but
> that's a different issue.)

Yes, investigating this for real is something I will address
soon.  Don't worry :)

> --- dmesg-2.6.17	2006-07-08 15:14:41.000000000 +0200
> +++ dmesg-2.6.18-rc1	2006-07-13 13:30:34.000000000 +0200
> ...
>  Kernel command line: ro root=LABEL=/
>  PID hash table entries: 1024 (order: 10, 8192 bytes)
> +start_kernel(): bug: interrupts were enabled early
>  Console: colour dummy device 80x25
>  Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
> 
> Something to worry about or not?

I'll check it out.

>  atyfb: fb0: ATY Mach64 frame buffer device on PCI
>  rtc_init: no PC rtc found
> -su0 at 0x000001fff13062f8 (irq = 5,7ea) is a 16550A
> -su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
> -ttyS0 at MMIO 0x1fff1400000 (irq = 6681504) is a SAB82532 V3.2
> -ttyS1 at MMIO 0x1fff1400040 (irq = 6681504) is a SAB82532 V3.2
> -isa bounce pool size: 16 pages
> +se@14,400000: ttyS1 at MMIO 0x1fff1400000 (irq = 5) is a SAB82532 V3.2
>  Floppy drive(s): fd0 is 1.44M
>  FDC 0 is a National Semiconductor PC87306
>  RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> 
> So ttyS0 became ttyS1, and the serial port at 0x1fff1400040
> disappeared. OTOH, my Ultra5 only has a single serial port
> connector so perhaps the old kernel was wrong in reporting
> two serial ports.

Two things are happening here.

1) The su ports are actually for the keyboard and mouse.
   I don't register them with the serial layer anymore for
   simplicity, and also because if they are driving the
   keyboard and mouse we really don't want people openning
   them as serial devices.

   I should probably add a little kernel log message for
   them, nevertheless.  I'll make that change right now.

2) I think the serial layer is confused about that ttyS1 thing.

   Take a look under /sys/class/tty/.  I bet there is a ttyS0
   directory, and underneath the "device" symlink points
   properly to your SAB82532 device node.

   If this is the case, it is using ttyS0 and ttyS1 is just
   an anomaly in how the serial core layer reports things.
   I've run into other problems in this area, so I know
   where to look to try and rectify things.

Thanks for the report!
