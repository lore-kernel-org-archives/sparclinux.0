From: David Miller <davem@davemloft.net>
Date: Fri, 17 Feb 2017 15:20:21 +0000
Subject: Re: [PATCH 08/35] sparc: Convert remaining use of pr_warning to pr_warn
Message-Id: <20170217.102021.1844776202845029133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1487314666.git.joe@perches.com>
        <d84b420939da59b66f099dc806469abff7dd0414.1487314667.git.joe@perches.com>
In-Reply-To: <d84b420939da59b66f099dc806469abff7dd0414.1487314667.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Thu, 16 Feb 2017 23:11:21 -0800

> To enable eventual removal of pr_warning
> 
> This makes pr_warn use consistent for arch/sparc
> 
> Prior to this patch, there was 1 use of pr_warning and
> 8 uses of pr_warn in arch/sparc
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: David S. Miller <davem@davemloft.net>
