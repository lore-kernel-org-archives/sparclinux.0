From: Michael Ellerman <patch-notifications@ellerman.id.au>
Date: Thu, 24 Sep 2020 12:28:10 +0000
Subject: Re: [PATCH v2 0/4] more mm switching vs TLB shootdown and lazy tlb fixes
Message-Id: <160094999385.26280.16775247303184322384.b4-ty@ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20200914045219.3736466-1-npiggin@gmail.com>
In-Reply-To: <20200914045219.3736466-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>, "linux-mm @ kvack . org" <linux-mm@kvack.org>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Mon, 14 Sep 2020 14:52:15 +1000, Nicholas Piggin wrote:
> This is an attempt to fix a few different related issues around
> switching mm, TLB flushing, and lazy tlb mm handling.
> 
> This will require all architectures to eventually move to disabling
> irqs over activate_mm, but it's possible we could add another arch
> call after irqs are re-enabled for those few which can't do their
> entire activation with irqs disabled.
> 
> [...]

Applied to powerpc/next.

[1/4] mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
      https://git.kernel.org/powerpc/c/d53c3dfb23c45f7d4f910c3a3ca84bf0a99c6143
[2/4] powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
      https://git.kernel.org/powerpc/c/66acd46080bd9e5ad2be4b0eb1d498d5145d058e
[3/4] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
      https://git.kernel.org/powerpc/c/bafb056ce27940c9994ea905336aa8f27b4f7275
[4/4] powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm
      https://git.kernel.org/powerpc/c/a665eec0a22e11cdde708c1c256a465ebe768047

cheers
