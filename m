From: David Miller <davem@davemloft.net>
Date: Sat, 14 Apr 2007 17:01:43 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070414.100143.83611034.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pasi Pirhonen <upi@centos.fi>
Date: Sat, 14 Apr 2007 13:38:30 +0300

> The sad part is that when i finally did got the right IOMMU-patch in
> and booted, the qlogicpti-driver did break as below. I know i could
> hack in a if() for 'SBUS_DMA_NONE', but i'd rather not as i have no
> idea how the SCSI-layer generally works ....
> 
> qlogicpti happily initializes when i just turned the plugged D1000 off

Thanks for reporting this, the qlogicpti driver should not try
to make a DMA mapping unless there really is a data transfer
going to happen.

I'll fix the bug in the qlogicpti driver and post the patch for
you.

Again, thanks for all the testing so far.
