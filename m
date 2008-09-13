From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 13 Sep 2008 13:11:05 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913131105.GA29070@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Sep 13, 2008 at 04:31:30AM +0200, Josip Rodin wrote:
> Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> PCI: Enabling device: (0001:00:02.0), cmd 81
> 0001:00:02.0: ttyS0 at I/O 0x1000940 (irq = 19) is a 16550A
> 0001:00:02.0: ttyS1 at I/O 0x1000948 (irq = 19) is a 16550A
> 
> Thanks a bunch :) minicom isn't giving me anything useful, but that might
> well be a cable issue :)

Hm, no, I just tested the cable between two x86s and it works - I ran
minicom with 9600N1 no hardware or software flow control, typed in something
on the one end and it came out on the other end, and vice versa. Doing the
same with the sparc didn't produce any result. I also tried connecting the
two ports on the card and running two minicoms each on its own ttyS[01], to
no avail. I'll have to take the card out and insert it into an x86 to see
whether it works in that environment.

-- 
     2. That which causes joy or happiness.
