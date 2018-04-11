From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 11 Apr 2018 08:34:19 +0000
Subject: Re: [PATCH v3 1/2] mm: introduce ARCH_HAS_PTE_SPECIAL
Message-Id: <20180411083419.GB23400@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523433816-14460-2-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523433816-14460-2-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 11-04-18 10:03:35, Laurent Dufour wrote:
> Currently the PTE special supports is turned on in per architecture header
> files. Most of the time, it is defined in arch/*/include/asm/pgtable.h
> depending or not on some other per architecture static definition.
> 
> This patch introduce a new configuration variable to manage this directly
> in the Kconfig files. It would later replace __HAVE_ARCH_PTE_SPECIAL.
> 
> Here notes for some architecture where the definition of
> __HAVE_ARCH_PTE_SPECIAL is not obvious:
> 
> arm
>  __HAVE_ARCH_PTE_SPECIAL which is currently defined in
> arch/arm/include/asm/pgtable-3level.h which is included by
> arch/arm/include/asm/pgtable.h when CONFIG_ARM_LPAE is set.
> So select ARCH_HAS_PTE_SPECIAL if ARM_LPAE.
> 
> powerpc
> __HAVE_ARCH_PTE_SPECIAL is defined in 2 files:
>  - arch/powerpc/include/asm/book3s/64/pgtable.h
>  - arch/powerpc/include/asm/pte-common.h
> The first one is included if (PPC_BOOK3S & PPC64) while the second is
> included in all the other cases.
> So select ARCH_HAS_PTE_SPECIAL all the time.
> 
> sparc:
> __HAVE_ARCH_PTE_SPECIAL is defined if defined(__sparc__) &&
> defined(__arch64__) which are defined through the compiler in
> sparc/Makefile if !SPARC32 which I assume to be if SPARC64.
> So select ARCH_HAS_PTE_SPECIAL if SPARC64
> 
> There is no functional change introduced by this patch.
> 
> Suggested-by: Jerome Glisse <jglisse@redhat>
> Reviewed-by: Jerome Glisse <jglisse@redhat>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Looks good to me. I have checked x86 and the generic code and it looks
good to me. Anyway arch maintainers really have to double check this.
-- 
Michal Hocko
SUSE Labs
