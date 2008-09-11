From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 22:40:58 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911.154058.99987422.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 00:19:51 +0200

> OK, some limited progress, the new kernel boot added the following into
> dmesg (damn that automagic udev thingy, I wanted to modprobe this like in
> the old days :):
> 
> Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> 8250_pci: Unknown symbol serial8250_unregister_port
> 8250_pci: Unknown symbol serial8250_resume_port
> 8250_pci: Unknown symbol serial8250_register_port
> 8250_pci: Unknown symbol serial8250_suspend_port
> Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> 8250_pci: Unknown symbol serial8250_unregister_port
> 8250_pci: Unknown symbol serial8250_resume_port
> 8250_pci: Unknown symbol serial8250_register_port
> 8250_pci: Unknown symbol serial8250_suspend_port
> 
> I don't get it, 8250.c defines these and they don't seem to be encumbered by
> anything...

Yes that looks strange.

I'd do a fresh build and make sure to do a full "make modules_install"
to make sure the depmod dependencies get generated properly.
