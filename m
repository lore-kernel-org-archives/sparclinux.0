From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Thu, 31 Jul 2008 23:51:23 +0000
Subject: Re: [PATCH] Revert "Merge branch 'x86/iommu' of
Message-Id: <20080801085106E.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <20080801094323.9601d87b.sfr@canb.auug.org.au>
In-Reply-To: <20080801094323.9601d87b.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: joerg.roedel@amd.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, davem@davemloft.net, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@elte.hu

On Fri, 1 Aug 2008 09:43:23 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This reverts commit 29111f579f4f3f2a07385f931854ab0527ae7ea5.
> 
> This undoes the hasty addition of a global version of iommu_num_pages()
> that broke both the powerpc and sparc builds.  This function can be
> revisited later.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/x86/kernel/amd_iommu.c   |   13 ++++++++-----
>  arch/x86/kernel/pci-gart_64.c |   11 +++++++----
>  include/linux/iommu-helper.h  |    1 -
>  lib/iommu-helper.c            |    8 --------
>  4 files changed, 15 insertions(+), 18 deletions(-)
> 
> This patch comes from
> git revert -m 1 29111f579f4f3f2a07385f931854ab0527ae7ea5
> 
> I have test built powerpc ppc64_defconfig and sparc64 defconfig.  The only
> references to iommu_num_pages() after this is applied are in the powerpc
> and sparc code.
> 
> Linus, please apply.  This is impacting on both powerpc and sparc
> development and even the author of the patches said that those patches
> were not urgent.

Ingo has a patch to fix this problem in the x86 tree:

http://marc.info/?l=linux-kernel&m1754062325903&w=2
