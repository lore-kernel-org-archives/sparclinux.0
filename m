From: David Rientjes <rientjes@google.com>
Date: Tue, 10 Apr 2018 20:51:06 +0000
Subject: Re: [PATCH v2 1/2] mm: introduce ARCH_HAS_PTE_SPECIAL
Message-Id: <alpine.DEB.2.21.1804101350250.79494@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1523373951-10981-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523373951-10981-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180410160932.GB3614@bombadil.infradead.org>
 <a732ef2b-445f-9ad8-014b-247c8c5d500b@linux.vnet.ibm.com>
In-Reply-To: <a732ef2b-445f-9ad8-014b-247c8c5d500b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 10 Apr 2018, Laurent Dufour wrote:

> > On Tue, Apr 10, 2018 at 05:25:50PM +0200, Laurent Dufour wrote:
> >>  arch/powerpc/include/asm/pte-common.h                  | 3 ---
> >>  arch/riscv/Kconfig                                     | 1 +
> >>  arch/s390/Kconfig                                      | 1 +
> > 
> > You forgot to delete __HAVE_ARCH_PTE_SPECIAL from
> > arch/riscv/include/asm/pgtable-bits.h
> 
> Damned !
> Thanks for catching it.
> 

Squashing the two patches together at least allowed it to be caught 
easily.  After it's fixed, feel free to add

	Acked-by: David Rientjes <rientjes@google.com>

Thanks for doing this!
