From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 09 Aug 2010 17:14:42 +0000
Subject: Re: [PATCH] sparc64: Fix perf_arch_get_caller_regs().
Message-Id: <20100809171440.GB5329@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100808.220450.148531617.davem@davemloft.net>
In-Reply-To: <20100808.220450.148531617.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 08, 2010 at 10:04:50PM -0700, David Miller wrote:
> 
> After b0f82b81fe6bbcf78d478071f33e44554726bc81 ("perf: Drop the skip
> argument from perf_arch_fetch_regs_caller") the build broke on sparc64
> due to the lack of a module symbol export of __perf_arch_fetch_caller_regs.
> 
> But that assembler helper can actually be complete eliminated now that
> the semantics of this interface have been greatly simplified.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> Frederic, I'll merge this to Linus via the sparc tree, this is
> just FYI...



Ok thanks a lot! I have no more access to a Sparc box, so I'm
sorry I can't anymore test perf and ftrace on this architecture :)

