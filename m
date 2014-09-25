From: Bob Picco <bpicco@meloft.net>
Date: Thu, 25 Sep 2014 16:20:05 +0000
Subject: Re: [PATCH V3] sparc64: sparse irq
Message-Id: <20140925162005.GB4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Thu Sep 25 2014, 11:53:21AM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Wed, 17 Sep 2014 15:31:28 -0400
> 
> > I've tested with SPARSE_IRQ on T5-8, M7-4 and T4-X and Jalap?no.
> 
> I'm currently reviewing this, and I have to ask if any of your Niagara
> test scenerios had a hypervisor with HV_GRP_INTR major < 3?
> 
> I have a sense that the legacy hypervisor case wasn't covered, and
> it seems that this patch will emit an ugly log message when that
> situation is triggered which probably isn't appropriate as the
> event isn't an error.  It's just an older hypervisor that lacks
> cookie only VIRQ support.
Yes this issue actually came up indirectly yesterday. Some T4-X will have
legacy sysino and some cookie. Though I've never seen a T4-X with cookie.
For example an older T4 with older HV firmware has this:
[root@ca-qasparc14 bugdb-19677751.d]# dmesg | grep hv_error
[    0.000000] irq_group_hv.129 hv_error = -22 major = 3
on an older kernel. I totally forgot about this issue.

You might have additional feedback. So please let me know whether you'd like
another version of the patch.
