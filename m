From: Alex Mach <alexvm12e@mail.ru>
Date: Mon, 17 May 2010 13:26:18 +0000
Subject: =?koi8-r?Q?Re=3A_sun4v=5Fdata=5Faccess=5Fexception_during_access_to_hardware?=
Message-Id: <E1OE0Ko-0003LP-00.alexvm12e-mail-ru@f148.mail.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> 
> > The problem happens when ethoc_read() call ioread32() with phys addr
> > 0xFFF0C2C100.
> 
> That means there is nothing responding at that physical address.

I need some help. If I want to have access to IO device I need to do following:

1. Get permission from hypervisor about using the phys addr;
2. Convert phys addr to real addr;
2. Initialize TSB by this real addr.

It's right? Which APIs should I use for these actions?

Thanks,
Alex



