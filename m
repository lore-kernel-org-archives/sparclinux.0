From: Bob Picco <bpicco@meloft.net>
Date: Thu, 25 Sep 2014 17:14:18 +0000
Subject: Re: [PATCH V3] sparc64: sparse irq
Message-Id: <20140925171418.GC4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Thu Sep 25 2014, 12:35:20PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Wed, 17 Sep 2014 15:31:28 -0400
> 
> > SPARC Virtual Machine Specification. HV_GRP_INTR is what controls the
> > cookie/sysino firmware versioning. The history appears to be something like
> > this:
> > 	major version 2 was dropped.
> > 	major version 3 is where a cookie only VIRQ
> > 	is possible. Using version 3 means ivector_table isn't required.
> 
> Can I get some clarification on this?
I'll attempt to but will have to make an inquiry. For me this came during
debug of painful P0 hardware.
> 
> Major version 2 of HV_GRP_INTR was meant to behave the way that
> you say major version 3 does.
This is what I recall but could be incorrect.
> 
> My understanding is that due to Solaris erratum 6496266, the
> hypervisor has to provide the VIRQ cookie interfaces even if the guest
> only negotiates major version 1.
Possibly for newer firmware but uncertain.
> 
> So supposedly, major version 3 was provided to untangle this mess.
This is what I observed but obviously could have been incorrect.
> 
> Can you clear this up for me?
I'll attempt to but consider this example. M7 was dead in the water, except
for my M7, because of an HV change which impacted sysino and cookies. So it
is possibe the firmware I observed this issue was never released?
> 
> Thanks.
> 
you're welcome.
