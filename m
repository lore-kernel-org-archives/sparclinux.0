From: David Miller <davem@davemloft.net>
Date: Fri, 29 Jul 2016 18:09:08 +0000
Subject: Re: [PATCH v2] sparc64: Trim page tables for 8M hugepages
Message-Id: <20160729.110908.235038737335500296.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1469778930-242969-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1469778930-242969-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: akpm@linux-foundation.org, julian.calaby@gmail.com, hughd@google.com, adam.buchbinder@gmail.com, minchan@kernel.org, kirill.shutemov@linux.intel.com, sfr@canb.auug.org.au, sudeep.holla@arm.com, chris.hyser@oracle.com, khalid.aziz@oracle.com, toshi.kani@hpe.com, mhocko@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 29 Jul 2016 00:54:21 -0700

> For PMD aligned (8M) hugepages, we currently allocate
> all four page table levels which is wasteful. We now
> allocate till PMD level only which saves memory usage
> from page tables.
> 
> Also, when freeing page table for 8M hugepage backed region,
> make sure we don't try to access non-existent PTE level.
> 
> Orabug: 22630259
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> ---
> Changelog v2 vs v1
>  - Combine fix for page table freeing with the main trimming patch (Dave)

Applied, thanks.
