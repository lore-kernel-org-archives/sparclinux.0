From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 09 Apr 2018 14:07:21 +0000
Subject: Re: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
Message-Id: <20180409140721.GI21835@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 09-04-18 15:57:06, Laurent Dufour wrote:
> The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
> per architecture header files. This doesn't allow to make other
> configuration dependent on it.
> 
> This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig files,
> setting it automatically when architectures was already setting it in
> header file.
> 
> There is no functional change introduced by this series.

I would just fold all three patches into a single one. It is much easier
to review that those selects are done properly when you can see that the
define is set for the same architecture.

In general, I like the patch. It is always quite painful to track per
arch defines.

> Laurent Dufour (3):
>   mm: introduce ARCH_HAS_PTE_SPECIAL
>   mm: replace __HAVE_ARCH_PTE_SPECIAL
>   mm: remove __HAVE_ARCH_PTE_SPECIAL
> 
>  Documentation/features/vm/pte_special/arch-support.txt | 2 +-
>  arch/arc/Kconfig                                       | 1 +
>  arch/arc/include/asm/pgtable.h                         | 2 --
>  arch/arm/Kconfig                                       | 1 +
>  arch/arm/include/asm/pgtable-3level.h                  | 1 -
>  arch/arm64/Kconfig                                     | 1 +
>  arch/arm64/include/asm/pgtable.h                       | 2 --
>  arch/powerpc/Kconfig                                   | 1 +
>  arch/powerpc/include/asm/book3s/64/pgtable.h           | 3 ---
>  arch/powerpc/include/asm/pte-common.h                  | 3 ---
>  arch/riscv/Kconfig                                     | 1 +
>  arch/s390/Kconfig                                      | 1 +
>  arch/s390/include/asm/pgtable.h                        | 1 -
>  arch/sh/Kconfig                                        | 1 +
>  arch/sh/include/asm/pgtable.h                          | 2 --
>  arch/sparc/Kconfig                                     | 1 +
>  arch/sparc/include/asm/pgtable_64.h                    | 3 ---
>  arch/x86/Kconfig                                       | 1 +
>  arch/x86/include/asm/pgtable_types.h                   | 1 -
>  include/linux/pfn_t.h                                  | 4 ++--
>  mm/Kconfig                                             | 3 +++
>  mm/gup.c                                               | 4 ++--
>  mm/memory.c                                            | 2 +-
>  23 files changed, 18 insertions(+), 24 deletions(-)
> 
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
