From: David Miller <davem@davemloft.net>
Date: Tue, 14 Feb 2017 18:04:37 +0000
Subject: Re: [PATCH v4 net-next 0/8] sunvnet driver updates
Message-Id: <20170214.130437.1795348617839754542.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1487012224-403399-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1487012224-403399-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 13 Feb 2017 10:56:56 -0800

> The sunvnet ldom virtual network driver was due for some updates and
> a bugfix or two.  These patches address a few items left over from
> last year's make-over.
> 
> v2:
>  - changed memory barrier fix to use smp_wmb
>  - put NETIF_F_SG back into the advertised ldmvsw hw_features
> 
> v3:
>  - the sunvnet_common module doesn't need module_init or _exit
> 
> v4:
>  - dropped the statistics patch
>  - fixed up "default" tag for SUNVNET_COMMON

Series applied, thanks.
