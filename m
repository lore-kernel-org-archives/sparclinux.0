From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 15:53:39 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913155339.GA27008@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Sep 13, 2008 at 03:11:05PM +0200, Josip Rodin wrote:
> On Sat, Sep 13, 2008 at 04:31:30AM +0200, Josip Rodin wrote:
> > Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> > PCI: Enabling device: (0001:00:02.0), cmd 81
> > 0001:00:02.0: ttyS0 at I/O 0x1000940 (irq = 19) is a 16550A
> > 0001:00:02.0: ttyS1 at I/O 0x1000948 (irq = 19) is a 16550A
> > 
> > Thanks a bunch :) minicom isn't giving me anything useful, but that might
> > well be a cable issue :)
> 
> Hm, no, I just tested the cable between two x86s and it works - I ran
> minicom with 9600N1 no hardware or software flow control, typed in something
> on the one end and it came out on the other end, and vice versa. Doing the
> same with the sparc didn't produce any result. I also tried connecting the
> two ports on the card and running two minicoms each on its own ttyS[01], to
> no avail. I'll have to take the card out and insert it into an x86 to see
> whether it works in that environment.

It works on x86_64 with 2.6.22.18 and 2.6.24.2 (will test with .26.5 soon).
The two ports can talk to each other, and they can also talk to the ports
on another such serial PCI card that I just bought (covering my bases :).

The first card is identified as:

% sudo lspci -v -s 05:08
05:08.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01) (prog-if 02 [16550])
        Subsystem: Timedia Technology Co Ltd Unknown device 4037
        Flags: stepping, medium devsel, IRQ 16
        I/O ports at 9c00 [size2]

The other card is identified as:

% sudo lspci -v -s 05:0a
05:0a.0 Serial controller: Oxford Semiconductor Ltd OX16PCI952 (Dual 16950 UART) (prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd Unknown device 0001
        Flags: medium devsel, IRQ 18
        I/O ports at 9800 [size=8]
        I/O ports at 9400 [size=8]
        I/O ports at 9000 [size2]
        Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
        Memory at fdffd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1

05:0a.1 Parallel controller: Oxford Semiconductor Ltd OX16PCI952 Integrated Parallel Port (prog-if 01 [BiDir])
        Subsystem: Oxford Semiconductor Ltd Unknown device 0001
        Flags: medium devsel, IRQ 18
        I/O ports at 8c00 [size=8]
        I/O ports at 8800 [size=4]
        I/O ports at 8400 [size2]
        Memory at fdffc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 1

After I test with 2.6.26.5, I'll put them both into the Sun Fire v240
and see how they do there.

-- 
     2. That which causes joy or happiness.
