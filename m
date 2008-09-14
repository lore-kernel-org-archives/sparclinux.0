From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 14 Sep 2008 12:30:54 +0000
Subject: Re: 16550 serial support
Message-Id: <20080914123054.GA21039@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Sep 14, 2008 at 01:01:16PM +0200, Josip Rodin wrote:
> Phew :) I'll rebuild the kernel with the patch shortly. Thanks!
> 
> I do wonder, however, why did sunsu register two ports, when there is no
> matching hardware... or maybe there is a chip that provides it, but there
> are no physical ports.
> 
> (I'll go set CONFIG_SERIAL_SUNSU=m rather than =y.)

OK, that didn't work out so well :)

Turns out udev selects 8250 before sunsu, if they are on level terms upon
boot, and that doesn't play too well with my preset getty settings, meaning
the machine sends semi-random data to the wrong ports, where the Fire 280R
happens to be listening and automatically reacts by effectively doing
Stop-A, and obviously badness ensues.

And the ALOM serial console also started misbehaving without sunsu in the
kernel image. It would show everything nicely up to the console handover,
then it would scroll to the top of the screen and proceed to write spaces
throughout the screen two times[1], but then it started printing a bunch of
output all on one line, as if it skipped all the line-breaks. Eventually it
would come to the point where there's a pause for the detection of SCSI
disks, and then the output would continue normally with line-breaks.

So I just reverted that change and put sunsu back into the kernel image.
The serial device-related dmesg output is now:

[...]
f00989ec: ttyS0 at MMIO 0x7fe010003f8 (irq = 15) is a 16550A
Console: ttyS0 (SU)
console [ttyS0] enabled
f009a454: ttyS1 at MMIO 0x7fe010002e8 (irq = 15) is a 16550A
[...]
pci 0001:00:02.0: supports D2
pci 0001:00:02.0: PME# supported from D0 D2 D3hot
pci 0001:00:02.0: PME# disabled
[...]
PCI: Enabling device: (0001:00:02.0), cmd 3
ttyS2: detected caps 00000700 should be 00000100
0001:00:02.0: ttyS2 at I/O 0x7fe01000930 (irq = 19) is a 16C950/954
ttyS3: detected caps 00000700 should be 00000100
0001:00:02.0: ttyS3 at I/O 0x7fe01000938 (irq = 19) is a 16C950/954
PCI: Enabling device: (0001:00:03.0), cmd 81
0001:00:03.0: ttyS4 at I/O 0x7fe010009a0 (irq = 20) is a 16550A
0001:00:03.0: ttyS5 at I/O 0x7fe010009a8 (irq = 20) is a 16550A

I have a getty from Fire 280R on this machine's ttyS2 and that's great.

Thanks again, and sorry for all this rambling.

[1] It always does that, although I don't quite see why... it could be
    related to the fact that it wants 34 lines whereas my terminals usually
    have just 24 lines. Also, on a normal boot (with sunsu on ttyS0 enabled
    from the start), I seem to be seeing numerous early boot messages
    printed twice. But that's much better than not seeing them at all,
    so this is not a complaint :)

-- 
     2. That which causes joy or happiness.
