From: David Miller <davem@davemloft.net>
Date: Fri, 26 May 2017 18:51:04 +0000
Subject: Re: [PATCH] arch/sparc: increase CONFIG_NODES_SHIFT on SPARC64 to 5
Message-Id: <20170526.145104.737140786434451704.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495741880-893167-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1495741880-893167-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jane.chu@oracle.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>
Date: Thu, 25 May 2017 13:51:20 -0600

> SPARC M6-32 platform has (2^5) NUMA nodes, so need to bump up the
> CONFIG_NODES_SHIFT to 5.
> 
> Orabug: 25577754
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> 
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Atish Patra <atish.patra@oracle.com>

This looks fine, applied, thanks.
