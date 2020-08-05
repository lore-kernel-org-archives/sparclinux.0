From: Baoquan He <bhe@redhat.com>
Date: Wed, 05 Aug 2020 09:11:05 +0000
Subject: Re: [PATCH v2 16/17] memblock: implement for_each_reserved_mem_region() using __next_mem_region()
Message-Id: <20200805091105.GW10792@MiWiFi-R3L-srv>
List-Id: <sparclinux.vger.kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-17-rppt@kernel.org>
In-Reply-To: <20200802163601.8189-17-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, ucli

On 08/02/20 at 07:36pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Iteration over memblock.reserved with for_each_reserved_mem_region() used
> __next_reserved_mem_region() that implemented a subset of
> __next_mem_region().
> 
> Use __for_each_mem_range() and, essentially, __next_mem_region() with
> appropriate parameters to reduce code duplication.
> 
> While on it, rename for_each_reserved_mem_region() to
> for_each_reserved_mem_range() for consistency.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .clang-format                    |  2 +-
>  arch/arm64/kernel/setup.c        |  2 +-
>  drivers/irqchip/irq-gic-v3-its.c |  2 +-
>  include/linux/memblock.h         | 12 +++------
>  mm/memblock.c                    | 46 +++++++-------------------------
>  5 files changed, 17 insertions(+), 47 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>
