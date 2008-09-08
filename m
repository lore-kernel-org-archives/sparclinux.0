From: David Miller <davem@davemloft.net>
Date: Mon, 08 Sep 2008 23:08:20 +0000
Subject: Re: kernel 2.6.26.3 qla2xxx oopsing on Fire 280R
Message-Id: <20080908.160820.20152853.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080908211331.GC22598@plap4-2.qlogic.org>
	<20080908.142351.00296600.davem@davemloft.net>
	<20080908214932.GF22598@plap4-2.qlogic.org>
In-Reply-To: <20080908214932.GF22598@plap4-2.qlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.vasquez@qlogic.com
Cc: joy@entuzijast.net, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

From: Andrew Vasquez <andrew.vasquez@qlogic.com>
Date: Mon, 8 Sep 2008 14:49:32 -0700

> Hmm...  Still looking...

Look at how the driver registers the IRQ handler before the host has
been registered with the SCSI layer.

That leads to a window of time where the shost hasn't been setup
fully, yet ISRs can come in and trigger DPC thread events, such as
loop resyncs, which expect the transport area to be setup.

But it won't be setup, because scsi_add_host() hasn't finished yet.

Note that in Josip's crash log, we don't even see the

	qla_printk(KERN_INFO, ha, "\n"
	    " QLogic Fibre Channel HBA Driver: %s\n"
	    "  QLogic %s - %s\n"
	    "  ISP%04X: %s @ %s hdma%c, host#=%ld, fw=%s\n",
 ...

message yet.

Which means that the crash occurs between qla2x00_request_irqs()
and printing that message.

