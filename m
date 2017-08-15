From: Meelis Roos <mroos@linux.ee>
Date: Tue, 15 Aug 2017 20:24:18 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <alpine.LRH.2.20.1708152321150.11510@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708151742360.29628@math.ut.ee> <20170815184403.GB4099@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170815184403.GB4099@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, Linux Kernel list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>

> On Tue, Aug 15, 2017 at 05:54:27PM +0300, Meelis Roos wrote:
> > I noticed that in 4.13.0-rc4 there is a new error in dmesg on my sparc64 
> > t5120 server: can't allocate MSI-X affinity masks.
> > 
> > [   30.274284] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.00-k.
> > [   30.274648] qla2xxx [0000:10:00.0]-001d: : Found an ISP2432 irq 21 iobase 0x000000c100d00000.
> > [   30.275447] qla2xxx 0000:10:00.0: can't allocate MSI-X affinity masks for 2 vectors
> > [   30.816882] scsi host1: qla2xxx
> > [   30.877294] qla2xxx: probe of 0000:10:00.0 failed with error -22
> > [   30.877578] qla2xxx [0000:10:00.1]-001d: : Found an ISP2432 irq 22 iobase 0x000000c100d04000.
> > [   30.878387] qla2xxx 0000:10:00.1: can't allocate MSI-X affinity masks for 2 vectors
> > [   31.367083] scsi host1: qla2xxx
> > [   31.427500] qla2xxx: probe of 0000:10:00.1 failed with error -22
> > 
> > I do not know if the driver works since nothing is attached to the FC 
> > HBA at the moment, but from the error messages it looks like the driver 
> > fails to load.
> > 
> > I booted 4.12 and 4.11 - the red error is not there but the failure 
> > seems to be the same error -22:

4.10.0 works, 4.11.0 errors out with EINVAL and 4.13-rc4 errorr sout 
with more verbose MSI messages. So something between 4.10 and 4.11 has 
broken it.

Also, 4.13-rc4 is broken on another sun4v here (T1000). So it seems to 
be sun4v interrupt related.

-- 
Meelis Roos (mroos@linux.ee)
