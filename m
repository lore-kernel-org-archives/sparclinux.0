From: David Miller <davem@davemloft.net>
Date: Sat, 07 May 2011 07:58:48 +0000
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
Message-Id: <20110507.005848.226775736.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sboyd@codeaurora.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-m32r@ml.linux-m32r.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, cmetcalf@tilera.com, user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri,  6 May 2011 22:57:11 -0700

> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
> 
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
> 
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: x86@kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: David S. Miller <davem@davemloft.net>
