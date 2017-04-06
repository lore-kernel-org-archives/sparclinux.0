From: David Miller <davem@davemloft.net>
Date: Thu, 06 Apr 2017 19:06:45 +0000
Subject: Re: [PATCH] sparc64: Fix kernel panic due to erroneous #ifdef surrounding pmd_write()
Message-Id: <20170406.120645.1470638295356870742.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Fri, 31 Mar 2017 16:31:42 -0600

> This commit moves sparc64's prototype of pmd_write() outside
> of the CONFIG_TRANSPARENT_HUGEPAGE ifdef.
> 
> In 2013, commit a7b9403f0e6d ("sparc64: Encode huge PMDs using PTE
> encoding.") exposed a path where pmd_write() could be called without
> CONFIG_TRANSPARENT_HUGEPAGE defined.  This can result in the panic below.
> 
> The diff is awkward to read, but the changes are straightforward.
> pmd_write() was moved outside of #ifdef CONFIG_TRANSPARENT_HUGEPAGE.
> Also, __HAVE_ARCH_PMD_WRITE was defined.
> 
> kernel BUG at include/asm-generic/pgtable.h:576!
 ...
> Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>

Applied.
