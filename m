From: David Miller <davem@davemloft.net>
Date: Mon, 21 Mar 2016 04:29:26 +0000
Subject: Re: [PATCH] sparc: Convert naked unsigned uses to unsigned int
Message-Id: <20160321.002926.1554370041407414508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <9a3bb519110397a1c70b4020577ddcef8810cb77.1457651534.git.joe@perches.com>
In-Reply-To: <9a3bb519110397a1c70b4020577ddcef8810cb77.1457651534.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Thu, 10 Mar 2016 15:21:43 -0800

> Use the more normal kernel definition/declaration style.
> 
> Done via:
> 
> $ git ls-files arch/sparc | \
>   xargs ./scripts/checkpatch.pl -f --fix-inplace --types=unspecified_int
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
