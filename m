From: David Miller <davem@davemloft.net>
Date: Thu, 25 Sep 2014 16:42:54 +0000
Subject: Re: [PATCH V3] sparc64: sparse irq
Message-Id: <20140925.124254.1617890769020408968.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410982288-10549-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 25 Sep 2014 12:20:05 -0400

> Yes this issue actually came up indirectly yesterday. Some T4-X will have
> legacy sysino and some cookie. Though I've never seen a T4-X with cookie.
> For example an older T4 with older HV firmware has this:

Ok.  Presumably, these systems support major=2 HV_GRP_IRQ.  Even back
to Huron and Ontario hypervisors I see major=2 support present.

> [root@ca-qasparc14 bugdb-19677751.d]# dmesg | grep hv_error
> [    0.000000] irq_group_hv.129 hv_error = -22 major = 3
> on an older kernel. I totally forgot about this issue.
> 
> You might have additional feedback. So please let me know whether you'd like
> another version of the patch.

If we agree about the log message, I can just kill it off myself when
applying your patch.
