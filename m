From: David Miller <davem@davemloft.net>
Date: Thu, 27 Sep 2007 20:18:49 +0000
Subject: Re: [PATCH] restore_current o0 register clobber
Message-Id: <20070927.131849.83860310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070826190858.bc86dea7.krzysztof.h1@wp.pl>
In-Reply-To: <20070826190858.bc86dea7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 26 Aug 2007 19:08:58 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch changes call definitions of the restore_current(void)
> to restore_current(int) to force usage of the o0 register. The o0
> register is used internally and compiler must not assume
> it is preserved during the call.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch is a NOP ;-)

The compiler already must assume that all outgoing argument registers
are potentially clobbered by the function being called, as that
function may use those registers freely as temporaries.  This is true
even if there are no arguments being passed in.

Therefore %o0 --> %o5 are free to use by any function called from C.

Otherwise a lot of things would simply not work.
