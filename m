From: David Miller <davem@davemloft.net>
Date: Fri, 29 Jul 2016 04:00:48 +0000
Subject: Re: [PATCH v2 2/2] sparc64: Fix pagetable freeing for hugepage regions
Message-Id: <20160728.210048.165773321219658930.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1466719639-143815-1-git-send-email-nitin.m.gupta@oracle.com>
	<1466719639-143815-2-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1466719639-143815-2-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, schwidefsky@de.ibm.com, kirill.shutemov@linux.intel.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 23 Jun 2016 15:05:36 -0700

> 8M pages now allocate page tables till PMD level only.
> So, when freeing page table for 8M hugepage backed region,
> make sure we don't try to access non-existent PTE level.
> 
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>

The manner in which you have submitted this change breaks
bisectability.

The "problem" you are fixing here is introduced by you in patch #1.

You need to combine these two changes together, otherwise there is
an intermediate state where the kernel is broken by your changes.
