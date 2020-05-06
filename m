From: David Miller <davem@davemloft.net>
Date: Wed, 06 May 2020 21:01:56 +0000
Subject: Re: [PATCH] sparc: mm: return true,false in kern_addr_valid()
Message-Id: <20200506.140156.2160110657988374613.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200506061659.19128-1-yanaijie@huawei.com>
In-Reply-To: <20200506061659.19128-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yanaijie@huawei.com
Cc: akpm@linux-foundation.org, rppt@linux.ibm.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 6 May 2020 14:16:59 +0800

> This function's return type is bool and returns both true/false and 0/1.
> This fixes the following coccicheck warning:
> 
> arch/sparc/mm/init_64.c:1652:9-10: WARNING: return of 0/1 in function
> 'kern_addr_valid' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied, thanks.
