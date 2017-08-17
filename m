From: Meelis Roos <mroos@linux.ee>
Date: Thu, 17 Aug 2017 10:17:46 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <alpine.LRH.2.20.1708171316490.29402@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708151742360.29628@math.ut.ee> <20170815184403.GB4099@bhelgaas-glaptop.roam.corp.google.com> <alpine.LRH.2.20.1708152321150.11510@math.ut.ee> <alpine.LRH.2.20.1708162136220.16834@math.ut.ee> <20170817100921.GA29888@lst.de>
In-Reply-To: <20170817100921.GA29888@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, Linux Kernel list <linux-kernel@vger.kernel.org>

> Just curious:  these are all SMP builds, right?

Yes. 32 threads on that CPU.

I am bisecting it slowly - some steps crash on boot for seemingly 
different reasons and skipping them does not advance quikly.

-- 
Meelis Roos (mroos@linux.ee)
