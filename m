From: David Miller <davem@davemloft.net>
Date: Mon, 21 Aug 2017 18:27:47 +0000
Subject: Re: 4.13.0-rc4 sparc64: can't allocate MSI-X affinity masks for 2 vectors
Message-Id: <20170821.112747.1532639515902173100.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1708152321150.11510@math.ut.ee>
	<alpine.LRH.2.20.1708162136220.16834@math.ut.ee>
	<20170816190241.GD28977@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170816190241.GD28977@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: helgaas@kernel.org
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, qla2xxx-upstream@qlogic.com, linux-kernel@vger.kernel.org, hch@lst.de

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 16 Aug 2017 14:02:41 -0500

> On Wed, Aug 16, 2017 at 09:39:08PM +0300, Meelis Roos wrote:
>> > > > I noticed that in 4.13.0-rc4 there is a new error in dmesg on my sparc64 
>> > > > t5120 server: can't allocate MSI-X affinity masks.
>> > > > 
>> > > > [   30.274284] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.00.00.00-k.
>> > > > [   30.274648] qla2xxx [0000:10:00.0]-001d: : Found an ISP2432 irq 21 iobase 0x000000c100d00000.
>> > > > [   30.275447] qla2xxx 0000:10:00.0: can't allocate MSI-X affinity masks for 2 vectors
>> > > > [   30.816882] scsi host1: qla2xxx
>> > > > [   30.877294] qla2xxx: probe of 0000:10:00.0 failed with error -22
>> > > > [   30.877578] qla2xxx [0000:10:00.1]-001d: : Found an ISP2432 irq 22 iobase 0x000000c100d04000.
>> > > > [   30.878387] qla2xxx 0000:10:00.1: can't allocate MSI-X affinity masks for 2 vectors
>> > > > [   31.367083] scsi host1: qla2xxx
>> > > > [   31.427500] qla2xxx: probe of 0000:10:00.1 failed with error -22
>> > > > 
>> > > > I do not know if the driver works since nothing is attached to the FC 
>> > > > HBA at the moment, but from the error messages it looks like the driver 
>> > > > fails to load.
>> > > > 
>> > > > I booted 4.12 and 4.11 - the red error is not there but the failure 
>> > > > seems to be the same error -22:
>> > 
>> > 4.10.0 works, 4.11.0 errors out with EINVAL and 4.13-rc4 errorr sout 
>> > with more verbose MSI messages. So something between 4.10 and 4.11 has 
>> > broken it.
>> 
>> I can not reproduice the older kernels that misbehave. I checked out 
>> earlier kernels and recompiled them (old config lost, nothing changed 
>> AFAIK), everything works up to 4.12 inclusive.
>> 
>> > Also, 4.13-rc4 is broken on another sun4v here (T1000). So it seems to 
>> > be sun4v interrupt related.
>> 
>> This still holds - 4.13-rc4 has MSI trouble on at least 2 of my sun4v 
>> machines.
> 
> IIUC, that means v4.12 works and v4.13-rc4 does not, so this is a
> regression we introduced this cycle.
> 
> If nobody steps up with a theory, bisecting might be the easiest path
> forward.

I suspect the test added by:

commit 6f9a22bc5775d231ab8fbe2c2f3c88e45e3e7c28
Author: Michael Hernandez <michael.hernandez@cavium.com>
Date:   Thu May 18 10:47:47 2017 -0700

    PCI/MSI: Ignore affinity if pre/post vector count is more than min_vecs

is triggering.

The rest of the failure cases are memory allocation failures which should
not be happening here.

There have only been 5 commits to kernel/irq/affinity.c since v4.10

I suppose we have been getting away with something that has silently
been allowed in the past, or something like that.

Meelis can you run with the following debuggingspatch?

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d69bd77252a7..d16c6326000a 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -110,6 +110,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	struct cpumask *masks;
 	cpumask_var_t nmsk, *node_to_present_cpumask;
 
+	pr_info("irq_create_affinity_masks: nvecs[%d] affd->pre_vectors[%d] "
+		"affd->post_vectors[%d]\n",
+		nvecs, affd->pre_vectors, affd->post_vectors);
 	/*
 	 * If there aren't any vectors left after applying the pre/post
 	 * vectors don't bother with assigning affinity.
