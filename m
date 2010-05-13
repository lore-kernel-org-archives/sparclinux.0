From: Alex Mach <alexvm12e@mail.ru>
Date: Thu, 13 May 2010 13:56:01 +0000
Subject: =?koi8-r?Q?Re[2]=3A_sun4v=5Fdata=5Faccess=5Fexception_during_access_to_hardware?=
Message-Id: <E1OCYtN-0006Xs-00.alexvm12e-mail-ru@f249.mail.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <E1OCWkP-0008St-00.alexvm12e-mail-ru@f211.mail.ru>
In-Reply-To: <E1OCWkP-0008St-00.alexvm12e-mail-ru@f211.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> The device doesn't have the proper backing information for the DMA
> layer on sparc64 requires, it needs an IOMMU struct pointer and other
> bits in the arch level device area setup properly.  And for non-PCI
> devices this isn't going to happen.
> 
> This isn't going to get fixed by simple changes, I'm sorry to inform
> you :-)

David I'm not using DMA buffer memory now. The problem happens when ethoc_read() call ioread32() with phys addr 0xFFF0C2C100. Could you advise me steps which should I do for using the driver for Sparc64 without DMA, please? Should I add the address of MAC to hypervisor or OBP MD? 

Thanks,
Alex.

