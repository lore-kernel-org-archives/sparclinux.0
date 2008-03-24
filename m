From: David Miller <davem@davemloft.net>
Date: Mon, 24 Mar 2008 20:39:21 +0000
Subject: Re: build breakage on sparc64 due to commit 54cd6dde
Message-Id: <20080324.133921.106716072.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200803242053.22709.m.kozlowski@tuxland.pl>
In-Reply-To: <200803242053.22709.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Mon, 24 Mar 2008 20:53:22 +0100

> 	I get this error when building latest Linus git (and 2.6.25-rc5-mm1) tree:
> 
> arch/sparc64/kernel/asm-offsets.c:1: error: -m64 is not supported by this configuration
> arch/sparc64/kernel/asm-offsets.c:1: error: -mlong-double-64 not allowed with -m64
> arch/sparc64/kernel/asm-offsets.c:1: error: -mcmodel= is not supported on 32 bit systems
> make[1]: *** [arch/sparc64/kernel/asm-offsets.s] Error 1

Are you cross-compiling?

If not, what kind of system is this?
