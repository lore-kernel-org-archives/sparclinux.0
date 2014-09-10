From: Bob Picco <bpicco@meloft.net>
Date: Wed, 10 Sep 2014 14:08:36 +0000
Subject: Re: [PATCH] sparc64: sparse irq
Message-Id: <20140910140836.GC17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104707-21563-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104707-21563-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 09 2014, 05:40:46PM EDT]
> From: Bob Picco <bob.picco@oracle.com>
> Date: Tue, 9 Sep 2014 15:34:24 -0400
> 
> > David Miller wrote:	[Tue Sep 09 2014, 03:17:52PM EDT]
> >> From: Bob Picco <bpicco@meloft.net>
> >> Date: Sun,  7 Sep 2014 11:45:07 -0400
> >> 
> >> > From: bob picco <bpicco@meloft.net>
> >> > 
> >> > This patch attempts to do a few things. The highlights are:  1) provides the
> >> > option to enable SPARSE_IRQ, 2) allocates ivector_table at boot time and
> >> > 3) default to cookie only VIRQ mechanism for supported firmware. The
> >> > first firmware with cookie only support for me appears on T5. You can
> >> > optionally force the HV firmware to not cookie only mode which is the
> >> > sysino support.
> >> > 
> >> > The sysino is a deprecated HV mechanism according to the most recent
> >> > SPARC Virtual Machine Specification. HV_GRP_INTR is what controls the
> >> > cookie/sysino firmware versioning. The history appears to be something like
> >> > this:
> >> > 	major version 2 was dropped.
> >> > 	major version 3 is where a cookie only VIRQ
> >> > 	is possible. Using version 3 means ivector_table isn't required.
> >> > 
> >> > A new boot option is provided should cookie only HV support have issues.
> >> > hvirq - this is the version for HV_GRP_INTR. This is related to HV API
> >> > versioning.  The code attempts major=3 first by default. The option can
> >> > be used to override this default.
> >> > 
> >> > I've tested with SPARSE_IRQ on T5-8, M7-4 and T4-X and Ultra 45. I've also
> >> > tested Ultra45 (Jalap?no) with !SPARSE_IRQ.
> >> > 
> >> > Cc: sparclinux@vger.kernel.org
> >> > Signed-off-by: Bob Picco <bob.picco@oracle.com>
> >> 
> >> Let's just bite the bullet and enable SPARSE_IRQ unconditionally
> >> on SPARC64.
> > Okay. Do you require more from me?
> 
> I only require that you respin this patch to unconditionally enable
> SPARSE_IRQ.
Okay, MAY_HAVE_SPARSE_IRQ will become SPARSE_IRQ.
> 
> Well, now that you are asking I do have a few more points I'm
> interested in :-)
Ah, this is okay :) 
> 
> In irq_alloc() you can probably just use irq_alloc_desc(), is IRQ 0
> really special in some way that we cannot allocate it?  That's the
> only reason I see for using __irq_alloc_descs().
My brain has atrophied for this reasoning - long time ago. I'll need to
investigate should you feel it important? I think timer irq but unsure.
> 
> Also, please use NUMA_NO_NODE for the node argument rather than -1.
Okay.
> I am assuming that at some point you will perhaps add some logic to
> pick a specific node if appropriate.
Yes.
> 
> Also, once you go to using SPARSE_IRQ always there is absolutely no
> reason to pick one NR_IRQS value over another.  I would suggest
> therefore that you use the maximum possible value which, reading
> your patch, seems to be something like 8192.
No this is good. I didn't like this aspect. I'll leave it at 8192. I really
have no clue what a good value will be for M7. The memory footprint is
neglible. The boot time memory is probably comparable to !SPARSE_IRQ.
So for 8192 we have a bitmap with 1UL << (13-3) bytes of bitmap.
> 
> If you still want the conditional NR_IRQS sizing in there, I want
> to see more details about what exactly determines the size you want
> to use.  It's based upon NR_CPUS now but I can't understand that.
> What matters is how many virtual or real devices having INOs exist
> in the machine, and that seems like a purely platform property to
> me.
At one time it was astronomically large because of being pulled away for bugs.
I was subjected to some of Bryce's wrath :)

thanx for the additional feedback,

bob
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
