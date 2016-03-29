From: David Miller <davem@davemloft.net>
Date: Tue, 29 Mar 2016 23:41:05 +0000
Subject: Re: [PATCH v3] sparc64: Reduce TLB flushes during hugepte changes
Message-Id: <20160329.194105.2209941679960771383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1459285913-141365-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1459285913-141365-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, khalid.aziz@oracle.com, minchan@kernel.org, aneesh.kumar@linux.vnet.ibm.com, zhenzhang.zhang@huawei.com, sfr@canb.auug.org.au, mingo@kernel.org, chris.hyser@oracle.com, dahi@linux.vnet.ibm.com, toshi.kani@hpe.com, tony.luck@intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue, 29 Mar 2016 14:11:14 -0700

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

You really need to put some more work into this, there are lots of
config variants you didn't even test.

See the kbuild robot replies...

