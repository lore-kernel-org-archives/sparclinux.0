From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 15 Aug 2010 19:41:48 +0000
Subject: XVR-600 console not working with e3d [was Re: please restore Sun
Message-Id: <20100815194147.GA26399@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 15, 2010 at 12:20:36PM -0400, Howard Eisenberger wrote:
> On 2010-08-14, Josip Rodin wrote:
> 
> > On Sat, Aug 14, 2010 at 11:52:43PM +0200, joy wrote:
> >> On Sat, Aug 14, 2010 at 10:09:06AM -0400, Howard Eisenberger wrote:
> >> > If it helps, I did this with the XVR-600 in my Ultra 60, but the
> >> > output stops with:
> >> > 
> >> > [    0.000000] OF stdout device is: /pci@1f,2000/SUNW,XVR-600@1
> >> > ...
> >> > [    0.000000] Console: colour dummy device 80x25
> >> > [    0.000000] console [tty0] enabled, bootconsole disabled
> >> > 
> >> > I am able to ssh into the machine.
> >> > 
> >> > # uname -a
> >> > Linux ultra60 2.6.32-5-sparc64-smp #1 SMP Thu Aug 12 18:24:18 \
> >> > UTC 2010 sparc64 GNU/Linux
> >> > 
> >> > # lspci -v
> >> > 0001:80:01.0 Display controller: 3DLabs Sun XVR-500 Graphics \
> >> > Accelerator (rev 01)
> >> >         Subsystem: 3DLabs Device 1047
> >> >         Flags: 66MHz, medium devsel, IRQ 22
> >> >         Memory at 04000000 (32-bit, prefetchable) [sizedM]
> >> >         Memory at 08000000 (32-bit, non-prefetchable) [size8K]
> >> >         Memory at 0a000000 (32-bit, prefetchable) [size2M]
> >> >         [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable)
> >> >         [size=1]
> >> >         [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable)
> >> >         [size=1]
> >> >         [virtual] Memory at fffffe0100000000 (32-bit, non-prefetchable)
> >> >         [size=1]
> >> >         Expansion ROM at fffffe0100000000 [disabled] [size=1]
> >> >         Capabilities: [68] Power Management version 1
> >> >         Kernel driver in use: e3d
> >> > 
> >> So it doesn't look like the kernel framebuffer drivers picked it up.
> >> So that should be 3d3d:1047... but from the looks of it, that's not
> >> the detection method on sparc, the driver is just looking for "SUNW,gfb"
> >> in the PROM data.
> >> 
> >> Can you install sparc-utils and run prtconf -v, and see if anything like
> >> that comes up?
> 
> # prtconf -v
> System Configuration:  Sun Microsystems  sun4u
> Memory size: 2048 Megabytes
> System Peripherals (Software Nodes):
> 
> SUNW,Ultra-60
>     packages (driver probably installed)
>         terminal-emulator (driver probably installed)
>         deblocker (driver probably installed)
>         obp-tftp (driver probably installed)
>         disk-label (driver probably installed)
>         SUNW,builtin-drivers (driver probably installed)
>         sun-keyboard (driver probably installed)
>     chosen (driver probably installed)
>     openprom (driver probably installed)
>         client-services (driver probably installed)
>     options (driver probably installed)
>     aliases (driver probably installed)
>     memory (driver probably installed)
>     virtual-memory (driver probably installed)
>     pci (driver probably installed)
>         ebus (driver probably installed)
>             auxio (driver probably installed)
>             power (driver probably installed)
>             SUNW,pll (driver probably installed)
>             sc (driver probably installed)
>             se (driver probably installed)
>             su (driver probably installed)
>             su (driver probably installed)
>             ecpp (driver probably installed)
>             fdthree (driver probably installed)
>             eeprom (driver probably installed)
>             flashprom (driver probably installed)
>             SUNW,CS4231 (driver probably installed)
>         network (driver probably installed)
>         scsi (driver probably installed)
>             disk (driver probably installed)
>             tape (driver probably installed)
>         scsi (driver probably installed)
>             disk (driver probably installed)
>             tape (driver probably installed)
>         usb (driver probably installed)
>         usb (driver probably installed)
>         usb (driver probably installed)
>         pci108e,676a (driver probably installed)
>     pci (driver probably installed)
>         SUNW,XVR-600 (driver probably installed)
>     counter-timer (driver probably installed)
>     SUNW,UltraSPARC-II (driver probably installed)
>     SUNW,UltraSPARC-II (driver probably installed)
>     SUNW,ffb (driver probably installed)
> 
> > Oh, and on second thought, also it looks like e3d is the signature of the
> > XVR-500 class driver (drivers/video/sunxvr500.c). That one also matches
> > devices by PCI subdevice ID (0x0140 or 0x1024) which is probably how you
> > get it.
> >
> > dmesg | grep e3d # ?
> 
> # dmesg | grep e3d
> [   77.017122] e3d: Found device at 0001:80:01.0

OK, so the conclusion from this is that either e3d (sunxvr500) driver needs
some fixes to support XVR-600, or we need some way of getting the other one
to activate?

Cc:ing kernel mailing list in case someone there has better input.
I found a thread from March this year where Dave was trying and failing
to reproduce a similar setup - maybe Howard can provide the missing link
now.

-- 
     2. That which causes joy or happiness.
