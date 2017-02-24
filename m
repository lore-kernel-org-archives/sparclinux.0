From: David Miller <davem@davemloft.net>
Date: Fri, 24 Feb 2017 16:26:41 +0000
Subject: Re: [PATCH] sparc64: Fix build error in flush_tsb_user_page
Message-Id: <20170224.112641.2202053555057368089.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1487934216-33897-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1487934216-33897-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, sfr@canb.auug.org.au, mike.kravetz@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Fri, 24 Feb 2017 03:03:16 -0800

> Patch "sparc64: Add 64K page size support"
> unconditionally used __flush_huge_tsb_one_entry()
> which is available only when hugetlb support is
> enabled.
> 
> Another issue was incorrect TSB flushing for 64K
> pages in flush_tsb_user().
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

Applied, thank you.
