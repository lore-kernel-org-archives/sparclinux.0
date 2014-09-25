From: Bob Picco <bpicco@meloft.net>
Date: Thu, 25 Sep 2014 18:54:38 +0000
Subject: Re: [PATCH V3] sparc64: sparse irq
Message-Id: <20140925185438.GF4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Thu Sep 25 2014, 01:34:20PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Thu, 25 Sep 2014 13:14:18 -0400
> 
> > David Miller wrote:	[Thu Sep 25 2014, 12:35:20PM EDT]
> >> From: Bob Picco <bpicco@meloft.net>
> >> Date: Wed, 17 Sep 2014 15:31:28 -0400
> >> 
> >> Major version 2 of HV_GRP_INTR was meant to behave the way that
> >> you say major version 3 does.
> > This is what I recall but could be incorrect.
> 
> I an attempt to test this, I'm using your patch but I modified it
> to negotiate HV_GRP_INTR major=2 and then use the cookie only
> routines if that succeeded.
> 
> The negotiation of major=2 works, but hv calls fail with EINVAL and
> other strange things.
> 
> Trying to investigate further, because making this work with major=2
> would be great because we could avoid the ivector table allocation
> on even more machines.
Now that I understand your motivation.
Okay. I just looked quickly at the current specification for UltraSPARC
Virtualization which possibly isn't publicly available.
For Group HV_GRP_INTR 1.X and 3.X are supported. 2.X was declared broken.
This I didn't have accessible to me at the time of debug. Also one needs to
read with extreme caution.

