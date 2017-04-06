From: David Miller <davem@davemloft.net>
Date: Thu, 06 Apr 2017 19:06:52 +0000
Subject: Re: [PATCH] sparc64: Fix memory corruption when THP is enabled
Message-Id: <20170406.120652.1137174864155852546.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1491000547-243467-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1491000547-243467-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, mingo@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 31 Mar 2017 15:48:53 -0700

> The memory corruption was happening due to incorrect
> TLB/TSB flushing of hugepages.
> 
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Applied.
