From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 13 Jul 2006 12:18:33 +0000
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
Message-Id: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200607091040.k69AewNu019891@harpo.it.uu.se>
In-Reply-To: <200607091040.k69AewNu019891@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, 12 Jul 2006 23:24:19 -0700 (PDT), David Miller wrote:
>From: Mikael Pettersson <mikpe@it.uu.se>
>Date: Sun, 9 Jul 2006 12:40:58 +0200 (MEST)
>
>> 2.6.17-git16 to 2.6.18-rc1 partially boot but crash and burn in
>> different places depending on kernel configuration: my standard
>> config got alignment exceptions in the floppy driver followed by
>> (sabre?) PCI errors and a hang; a minimal kernel gets further but
>> fails "su" probe and then oopses hard when the /dev/hda partition
>> table is about to be printed.
>
>Several bugs operating here, all of which should be addressed by this
>patch below.  I was able to bootup my ultra5 fully, use the keyboard
>to login, etc. etc.

Confirmed. With this patch my Ultra5 boots fine again. Thanks.

(I still need that patch to repair PCI mmap() for X11, but
that's a different issue.)

>Let me know if you have any remaining problems.

No actual problems, but I noticed some differences in the
kernel log:

--- dmesg-2.6.17	2006-07-08 15:14:41.000000000 +0200
+++ dmesg-2.6.18-rc1	2006-07-13 13:30:34.000000000 +0200
...
 Kernel command line: ro root=LABEL=/
 PID hash table entries: 1024 (order: 10, 8192 bytes)
+start_kernel(): bug: interrupts were enabled early
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)

Something to worry about or not?

...
 Console: switching to colour frame buffer device 144x56
 atyfb: fb0: ATY Mach64 frame buffer device on PCI
 rtc_init: no PC rtc found
-su0 at 0x000001fff13062f8 (irq = 5,7ea) is a 16550A
-su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
-ttyS0 at MMIO 0x1fff1400000 (irq = 6681504) is a SAB82532 V3.2
-ttyS1 at MMIO 0x1fff1400040 (irq = 6681504) is a SAB82532 V3.2
-isa bounce pool size: 16 pages
+se@14,400000: ttyS1 at MMIO 0x1fff1400000 (irq = 5) is a SAB82532 V3.2
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a National Semiconductor PC87306
 RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

So ttyS0 became ttyS1, and the serial port at 0x1fff1400040
disappeared. OTOH, my Ultra5 only has a single serial port
connector so perhaps the old kernel was wrong in reporting
two serial ports.

/Mikael
