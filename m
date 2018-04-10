From: Palmer Dabbelt <palmer@sifive.com>
Date: Tue, 10 Apr 2018 20:44:46 +0000
Subject: Re: [PATCH v2 1/2] mm: introduce ARCH_HAS_PTE_SPECIAL
Message-Id: <mhng-dc76549e-6083-49a7-af3f-2638193f6698@palmer-si-x1c4>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <20180410160932.GB3614@bombadil.infradead.org>
References: <1523373951-10981-2-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1523373951-10981-2-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 10 Apr 2018 09:09:32 PDT (-0700), willy@infradead.org wrote:
> On Tue, Apr 10, 2018 at 05:25:50PM +0200, Laurent Dufour wrote:
>>  arch/powerpc/include/asm/pte-common.h                  | 3 ---
>>  arch/riscv/Kconfig                                     | 1 +
>>  arch/s390/Kconfig                                      | 1 +
>
> You forgot to delete __HAVE_ARCH_PTE_SPECIAL from
> arch/riscv/include/asm/pgtable-bits.h

Thanks -- I was looking for that but couldn't find it and assumed I'd just 
misunderstood something.
