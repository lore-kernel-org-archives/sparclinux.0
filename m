From: David Miller <davem@davemloft.net>
Date: Tue, 18 May 2010 19:36:14 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <20100518.123614.133386989.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Mach <alexvm12e@mail.ru>
Date: Tue, 18 May 2010 16:43:40 +0400

> Sure it should not always grant a requested access, it should lock
> the address ranges used by guest systems and so prevent granting
> access to other systems to the locked addresses. Isn't it? I just
> find strange if adding a device that uses physical IO space (any
> non-PnP ISA card for example) will result in pathching the
> OpenFirmware.

I/O space is protected as well, because it is also valid and common
to make certain I/O devices only accessible to certain guests in the
system.

In fact, the PCI host controller's registers aren't accesible at
all by any guest, it is only accessible by the hypervisor itself.
Even programming DMA mappings into the IOMMU has to go through
hypervisor calls.
