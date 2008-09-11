From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 11 Sep 2008 22:19:51 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911221951.GA15542@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 11, 2008 at 02:42:50PM -0700, David Miller wrote:
> The following patch should get it building for you so you can test it out.
> Meanwhile, I'll toss this into sparc-next-2.6

OK, some limited progress, the new kernel boot added the following into
dmesg (damn that automagic udev thingy, I wanted to modprobe this like in
the old days :):

Serial: 8250/16550 driver4 ports, IRQ sharing disabled
8250_pci: Unknown symbol serial8250_unregister_port
8250_pci: Unknown symbol serial8250_resume_port
8250_pci: Unknown symbol serial8250_register_port
8250_pci: Unknown symbol serial8250_suspend_port
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
8250_pci: Unknown symbol serial8250_unregister_port
8250_pci: Unknown symbol serial8250_resume_port
8250_pci: Unknown symbol serial8250_register_port
8250_pci: Unknown symbol serial8250_suspend_port

I don't get it, 8250.c defines these and they don't seem to be encumbered by
anything...

-- 
     2. That which causes joy or happiness.
