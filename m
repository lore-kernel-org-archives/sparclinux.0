From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 11 Sep 2008 23:15:43 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911231543.GA27709@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 11, 2008 at 03:40:58PM -0700, David Miller wrote:
> > Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> > 8250_pci: Unknown symbol serial8250_unregister_port
> > 8250_pci: Unknown symbol serial8250_resume_port
> > 8250_pci: Unknown symbol serial8250_register_port
> > 8250_pci: Unknown symbol serial8250_suspend_port
> > 
> > I don't get it, 8250.c defines these and they don't seem to be encumbered by
> > anything...
> 
> Yes that looks strange.
> 
> I'd do a fresh build and make sure to do a full "make modules_install"
> to make sure the depmod dependencies get generated properly.

Oh, it's definitely a build issue, after I wiped out the modules directory
and re-ran modules_install, depmod warned about the same issue.

So I did a make clean and rebuilt, rebooted, and it still has the same
problem :/

I vaguely remember having something likes on x86 a couple of times.

Once it happened when I tried to insert the smc-ircc2 IRDA driver, it needed
to be loaded before the native 8250 stuff. In that case it was vice-verse -
the irda stuff showed undefined symbols.

And then another time I saw the problem with Xen - I told it to use ttyS0
for its own console, and then the 8250 modules couldn't get loaded because of
its undefined symbols (possibly the very same ones as the above), until I
switched 'xencons' over to ttyS31.

Could it be that the sunsu driver is somehow disturbing 8250?

(Should we Cc: this to some other mailing list?)

-- 
     2. That which causes joy or happiness.
