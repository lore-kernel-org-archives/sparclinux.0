From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 14 Sep 2008 11:01:16 +0000
Subject: Re: 16550 serial support
Message-Id: <20080914110116.GB7810@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Sep 13, 2008 at 09:31:52PM -0700, David Miller wrote:
> > PCI: Enabling device: (0001:00:03.0), cmd 81
> > 0001:00:03.0: ttyS2 at I/O 0x10009a0 (irq = 20) is a 16550A
> > 0001:00:03.0: ttyS3 at I/O 0x10009a8 (irq = 20) is a 16550A
> > PCI: Enabling device: (0001:00:02.0), cmd 3
> > 0001:00:02.0: ttyS0 at I/O 0x1000930 (irq = 19) is a 16C950/954
> > 0001:00:02.0: ttyS1 at I/O 0x1000938 (irq = 19) is a 16C950/954
> 
> I see what's happening, uart_report_port() assumes a direct
> relationship between port->line and the ttyXXX device indexes.
> But that isn't true in situations where the device major's
> minor number space is shared between differnt drivers.
> 
> The reporting is just wrong, these devices are using ttyS2,
> ttyS3, ttyS4, and ttyS5.
> 
> This patch should fix most cases.

Phew :) I'll rebuild the kernel with the patch shortly. Thanks!

I do wonder, however, why did sunsu register two ports, when there is no
matching hardware... or maybe there is a chip that provides it, but there
are no physical ports.

(I'll go set CONFIG_SERIAL_SUNSU=m rather than =y.)

-- 
     2. That which causes joy or happiness.
