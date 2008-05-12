From: David Miller <davem@davemloft.net>
Date: Mon, 12 May 2008 01:05:27 +0000
Subject: Re: [PATCH] sparc32: fix rtrap.S typo
Message-Id: <20080511.180527.193704832.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4827933A.90507@earthlink.net>
In-Reply-To: <4827933A.90507@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sun, 11 May 2008 20:45:46 -0400

> Fix compile problem in rtrap.S
> 
> arch/sparc/kernel/built-in.o: In function `ret_trap_userwins_ok':
> arch/sparc/kernel/rtrap.S:(.text+0x1900): undefined reference to 
> `PSR_SYCALL'
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

APplied, thanks Robert.
