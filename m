From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 11 Sep 2008 23:27:29 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911232729.GA28884@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 12, 2008 at 01:15:43AM +0200, Josip Rodin wrote:
> > > Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> > > 8250_pci: Unknown symbol serial8250_unregister_port
> > > 8250_pci: Unknown symbol serial8250_resume_port
> > > 8250_pci: Unknown symbol serial8250_register_port
> > > 8250_pci: Unknown symbol serial8250_suspend_port
> > > 
> > > I don't get it, 8250.c defines these and they don't seem to be encumbered by
> > > anything...

Oh, I think I have a small clue... the latter four messages come from
the 8250_pci loading attempt, but the first message is from the 8250 loading
attempt - which also fails (but does the printk which makes it look all
right). A standalone attempt reveals:

% sudo modprobe 8250
FATAL: Error inserting 8250 (/lib/modules/2.6.27-rc4/kernel/drivers/serial/8250.ko): Device or resource busy
% 

That should be EBUSY, and that gets mentioned twice in
serial8250_request_std_resource() and once in
serial8250_request_rsa_resource(), after failures of request_mem_region()
and request_region(). Both of those are macros for __request_region().
The stuff past that is uncharted territory for me :)

-- 
     2. That which causes joy or happiness.
