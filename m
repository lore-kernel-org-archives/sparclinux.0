From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 17:49:45 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913174945.GA16127@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Sep 13, 2008 at 05:53:39PM +0200, Josip Rodin wrote:
> On Sat, Sep 13, 2008 at 03:11:05PM +0200, Josip Rodin wrote:
> > On Sat, Sep 13, 2008 at 04:31:30AM +0200, Josip Rodin wrote:
> > > Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> > > PCI: Enabling device: (0001:00:02.0), cmd 81
> > > 0001:00:02.0: ttyS0 at I/O 0x1000940 (irq = 19) is a 16550A
> > > 0001:00:02.0: ttyS1 at I/O 0x1000948 (irq = 19) is a 16550A
> > > 
> > > Thanks a bunch :) minicom isn't giving me anything useful, but that might
> > > well be a cable issue :)
> > 
> > Hm, no, I just tested the cable between two x86s and it works - I ran
> > minicom with 9600N1 no hardware or software flow control, typed in something
> > on the one end and it came out on the other end, and vice versa. Doing the
> > same with the sparc didn't produce any result. I also tried connecting the
> > two ports on the card and running two minicoms each on its own ttyS[01], to
> > no avail. I'll have to take the card out and insert it into an x86 to see
> > whether it works in that environment.
> 
> It works on x86_64 with 2.6.22.18 and 2.6.24.2 (will test with .26.5 soon).
[...]
> After I test with 2.6.26.5, I'll put them both into the Sun Fire v240
> and see how they do there.

I tested it with 2.6.26.5 on x86_64 - that also works.
testing with v240 later (I'm not physically nearby currently).

After being put into the v240, they reliably stop working :/

The lspci output on the sparc machine is this:

% sudo lspci -v -s 0001:00:03
0001:00:03.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01) (prog-if 02 [16550])
        Subsystem: Timedia Technology Co Ltd Unknown device 4037
        Flags: stepping, medium devsel, IRQ 20
        I/O ports at 09a0 [size2]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Expansion ROM at fffff80100000000 [disabled] [size=1]

% sudo lspci -v -s 0001:00:02
0001:00:02.0 Serial controller: Oxford Semiconductor Ltd OX16PCI952 (Dual 16950 UART) (prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd Unknown device 0001
        Flags: medium devsel, IRQ 19
        I/O ports at 0930 [size=8]
        I/O ports at 0938 [size=8]
        I/O ports at 0940 [size2]
        Memory at 00100000 (32-bit, non-prefetchable) [size=8K]
        Memory at 00102000 (32-bit, non-prefetchable) [size=8K]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Expansion ROM at fffff80100000000 [disabled] [size=1]
        Capabilities: [40] Power Management version 1

0001:00:02.1 Parallel controller: Oxford Semiconductor Ltd OX16PCI952 Integrated Parallel Port (prog-if 01 [BiDir])
        Subsystem: Oxford Semiconductor Ltd Unknown device 0001
        Flags: medium devsel, IRQ 19
        I/O ports at 0960 [disabled] [size=8]
        I/O ports at 0968 [disabled] [size=4]
        I/O ports at 0980 [disabled] [size2]
        Memory at 00104000 (32-bit, non-prefetchable) [disabled] [size=8K]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80100000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Expansion ROM at fffff80100000000 [disabled] [size=1]
        Capabilities: [40] Power Management version 1

Here's also the printks:

% dmesg | grep 1:00:03
PCI: Enabling device: (0001:00:03.0), cmd 81
0001:00:03.0: ttyS2 at I/O 0x10009a0 (irq = 20) is a 16550A
0001:00:03.0: ttyS3 at I/O 0x10009a8 (irq = 20) is a 16550A

% dmesg | grep 1:00:02
pci 0001:00:02.0: supports D2
pci 0001:00:02.0: PME# supported from D0 D2 D3hot
pci 0001:00:02.0: PME# disabled
pci 0001:00:02.1: supports D2
pci 0001:00:02.1: PME# supported from D0 D2 D3hot
pci 0001:00:02.1: PME# disabled
PCI: Enabling device: (0001:00:02.0), cmd 3
0001:00:02.0: ttyS0 at I/O 0x1000930 (irq = 19) is a 16C950/954
0001:00:02.0: ttyS1 at I/O 0x1000938 (irq = 19) is a 16C950/954

-- 
     2. That which causes joy or happiness.
