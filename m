From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jul 2017 19:38:26 +0000
Subject: Re: [PATCH] sparc64: Register hugepages during arch init
Message-Id: <20170720.123826.134998342859576670.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500509583-192121-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1500509583-192121-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: bob.picco@oracle.com, pasha.tatashin@oracle.com, steven.sistare@oracle.com, paul.gortmaker@windriver.com, thomas.tai@oracle.com, atish.patra@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 19 Jul 2017 17:12:54 -0700

> Add hstate for each supported hugepage size using
> arch initcall. This change fixes some hugepage
> parameter parsing inconsistencies:
> 
> case 1: no hugepage parameters
> 
>  Without hugepage parameters, only a hugepages-8192kB entry is visible
>  in sysfs.  It's different from x86_64 where both 2M and 1G hugepage
>  sizes are available.
> 
> case 2: default_hugepagesz=[64K|256M|2G]
> 
>  When specifying only a default_hugepagesz parameter, the default
>  hugepage size isn't really changed and it stays at 8M. This is again
>  different from x86_64.
> 
> Orabug: 25869946
> 
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Applied and queued up for -stable, thanks.
