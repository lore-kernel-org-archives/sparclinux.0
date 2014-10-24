From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 24 Oct 2014 04:54:55 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141024045454.GA8138@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20141022.163949.1761351331649936601.davem@davemloft.net>
 <alpine.LRH.2.11.1410230221360.28745@adalberg.ut.ee>
 <20141023.130258.548864295965807596.davem@davemloft.net>
 <20141023.172258.1371479087269518956.davem@davemloft.net>
In-Reply-To: <20141023.172258.1371479087269518956.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

A minor detail.

> [PATCH] sparc64: Fix register corruption in top-most kernel stack frame during boot.
> 
> -	call	start_kernel
> +	call start_early_boot

Maybe add a comment about stack use - as per your nice patch description.

> +void __init start_early_boot(void)

This will likely result in sparse complaining about:
fuction not declared - should it be static?

A prototype in include/asm/setup.h would be nice.

Other than this - very nice detective work!

	Sam
