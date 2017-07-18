From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2017 18:39:43 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <20170718.113943.65530531709532652.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: jane.chu@oracle.com
Date: Mon, 17 Jul 2017 15:11:03 -0700

> Thanks for digging in.  I will try your patch to  gather what I could
> share the data.

So, further inspection shows that we limit batches to 192 entries so
we will never see the full extent of an unmap in the statistics for
large operations.
