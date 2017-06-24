From: Richard Henderson <rth@twiddle.net>
Date: Sat, 24 Jun 2017 15:08:43 +0000
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
Message-Id: <60bd9a54-0220-5d52-8843-ea3a654020a6@twiddle.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
 <20170623220857.28774-1-palmer@dabbelt.com>
 <20170623220857.28774-2-palmer@dabbelt.com>
In-Reply-To: <20170623220857.28774-2-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/23/2017 03:08 PM, Palmer Dabbelt wrote:
> We wanted to add RISC-V to the list of architectures that used the
> generic PCI setup-irq.o inside the Makefile and it was suggested that
> instead we define a Kconfig entry and use that.
> 
> I've done very minimal testing on this: I just checked to see that
> an aarch64 defconfig still build setup-irq.o with the patch applied.
> The intention is that this patch doesn't change the behavior of any
> build.
> 
> Signed-off-by: Palmer Dabbelt<palmer@dabbelt.com>
> Reviewed-by: James Hogan<james.hogan@imgtec.com>
> ---
>   arch/alpha/Kconfig     |  1 +

Acked-by: Richard Henderson <rth@twiddle.net>


r~
