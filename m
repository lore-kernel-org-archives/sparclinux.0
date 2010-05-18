From: Alex Mach <alexvm12e@mail.ru>
Date: Tue, 18 May 2010 12:43:40 +0000
Subject: =?koi8-r?Q?Re[2]=3A_sun4v=5Fdata=5Faccess=5Fexception_during_access_to_hardware?=
Message-Id: <E1OEM96-0005f3-00.alexvm12e-mail-ru@f35.mail.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <E1OCWkP-0008St-00.alexvm12e-mail-ru@f211.mail.ru>
In-Reply-To: <E1OCWkP-0008St-00.alexvm12e-mail-ru@f211.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > 
> >> 
> >> > The problem happens when ethoc_read() call ioread32() with phys addr
> >> > 0xFFF0C2C100.
> >> 
> >> That means there is nothing responding at that physical address.
> > 
> > I need some help. If I want to have access to IO device I need to do following:
> > 
> > 1. Get permission from hypervisor about using the phys addr;
> > 2. Convert phys addr to real addr;
> > 2. Initialize TSB by this real addr.
> > 
> > It's right? Which APIs should I use for these actions?
> 
> You're likely need to make hypervisor changes to make this work.
> 
> There are no APIs for privileged level code to ask the hypervisor to
> just do these things.  If it did, the hypervisor would be useless,
> it's there exactly to protect the system from privileged code
> accessing arbitrary physical and I/O memory.
> 
> What probably is the easiest way is to make sure the OpenFirmware
> device tree has a proper nodes and mappings for your device.

Sure it should not always grant a requested access, it should lock the address ranges used by guest systems and so prevent granting access to other systems to the locked addresses. Isn't it? I just find strange if adding a device that uses physical IO space (any non-PnP ISA card for example) will result in pathching the OpenFirmware.

