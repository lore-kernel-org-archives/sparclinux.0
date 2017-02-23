From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:32:18 +0000
Subject: Re: [PATCH v6] sparc64: Multi-page size support
Message-Id: <20170223.113218.2219144071313988229.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1485994656-115830-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1485994656-115830-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, akpm@linux-foundation.org, julian.calaby@gmail.com, hughd@google.com, adam.buchbinder@gmail.com, kirill.shutemov@linux.intel.com, sfr@canb.auug.org.au, paul.gortmaker@windriver.com, thomas.tai@oracle.com, chris.hyser@oracle.com, khalid.aziz@oracle.com, atish.patra@oracle.com, mhocko@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed,  1 Feb 2017 16:16:36 -0800

> Add support for using multiple hugepage sizes simultaneously
> on mainline. Currently, support for 256M has been added which
> can be used along with 8M pages.
> 
> Page tables are set like this (e.g. for 256M page):
>     VA + (8M * x) -> PA + (8M * x) (sz bit = 256M) where x in [0, 31]
> 
> and TSB is set similarly:
>     VA + (4M * x) -> PA + (4M * x) (sz bit = 256M) where x in [0, 63]
> 
> - Testing
> 
> Tested on Sonoma (which supports 256M pages) by running stream
> benchmark instances in parallel: one instance uses 8M pages and
> another uses 256M pages, consuming 48G each.
> 
> Boot params used:
> 
> default_hugepagesz%6M hugepagesz%6M hugepages00 hugepagesz=8M
> hugepages000
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Applied, thanks.
