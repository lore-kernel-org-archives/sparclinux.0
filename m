From: Bob Picco <bob.picco@oracle.com>
Date: Tue, 09 Sep 2014 19:34:24 +0000
Subject: Re: [PATCH] sparc64: sparse irq
Message-Id: <20140909193424.GN24131@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104707-21563-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104707-21563-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 09 2014, 03:17:52PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Sun,  7 Sep 2014 11:45:07 -0400
> 
> > From: bob picco <bpicco@meloft.net>
> > 
> > This patch attempts to do a few things. The highlights are:  1) provides the
> > option to enable SPARSE_IRQ, 2) allocates ivector_table at boot time and
> > 3) default to cookie only VIRQ mechanism for supported firmware. The
> > first firmware with cookie only support for me appears on T5. You can
> > optionally force the HV firmware to not cookie only mode which is the
> > sysino support.
> > 
> > The sysino is a deprecated HV mechanism according to the most recent
> > SPARC Virtual Machine Specification. HV_GRP_INTR is what controls the
> > cookie/sysino firmware versioning. The history appears to be something like
> > this:
> > 	major version 2 was dropped.
> > 	major version 3 is where a cookie only VIRQ
> > 	is possible. Using version 3 means ivector_table isn't required.
> > 
> > A new boot option is provided should cookie only HV support have issues.
> > hvirq - this is the version for HV_GRP_INTR. This is related to HV API
> > versioning.  The code attempts major=3 first by default. The option can
> > be used to override this default.
> > 
> > I've tested with SPARSE_IRQ on T5-8, M7-4 and T4-X and Ultra 45. I've also
> > tested Ultra45 (Jalap?no) with !SPARSE_IRQ.
> > 
> > Cc: sparclinux@vger.kernel.org
> > Signed-off-by: Bob Picco <bob.picco@oracle.com>
> 
> Let's just bite the bullet and enable SPARSE_IRQ unconditionally
> on SPARC64.
Okay. Do you require more from me?
> 
> That will decrease the vmlinux image size and increase the testing
> coverage of SPARSE_IRQ.
Sounds good.

thanx,

bob
