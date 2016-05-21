From: David Miller <davem@davemloft.net>
Date: Sat, 21 May 2016 01:45:15 +0000
Subject: Re: [PATCH v4] sparc64: Reduce TLB flushes during hugepte changes
Message-Id: <20160520.214515.1319667674362252733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1459362165-79634-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1459362165-79634-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, khalid.aziz@oracle.com, aneesh.kumar@linux.vnet.ibm.com, adam.buchbinder@gmail.com, minchan@kernel.org, sfr@canb.auug.org.au, sudeep.holla@arm.com, mingo@kernel.org, chris.hyser@oracle.com, dahi@linux.vnet.ibm.com, toshi.kani@hpe.com, tony.luck@intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 30 Mar 2016 11:17:13 -0700

> During hugepage map/unmap, TSB and TLB flushes are currently
> issued at every PAGE_SIZE'd boundary which is unnecessary.
> We now issue the flush at REAL_HPAGE_SIZE boundaries only.
> 
> Without this patch workloads which unmap a large hugepage
> backed VMA region get CPU lockups due to excessive TLB
> flush calls.
> 
> Orabug: 22365539, 22643230, 22995196
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Looks good, applied and queued up for -stable.

Thanks for being so patient.
