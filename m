From: David Miller <davem@davemloft.net>
Date: Fri, 25 Aug 2006 07:47:21 +0000
Subject: Re: [PATCH] sparc32: enabling of the 2nd CPU in 2.6.18-rc4
Message-Id: <20060825.004721.21929598.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44ee0fc356c3e@wp.pl>
In-Reply-To: <44ee0fc356c3e@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Thu, 24 Aug 2006 22:44:51 +0200

> From: Krzysztof Helt (krzysztof.h1@wp.pl)
> 
> This is smp_setup_cpu_possible_map() move after the patch did by
> davem to sparc64.
> 
> Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)

It took me a while to figure out what this patch was
all about, please provide context and reasons why the
change needs to be made.

I changed the changelog to what you should have said,
to give you an idea:

--------------------
[SPARC]: enabling of the 2nd CPU in 2.6.18-rc4

smp_setup_cpu_possible_map() needs to run after paging_init()
so that the in-kernel device tree is setup.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: David S. Miller <davem@davemloft.net>
--------------------

See?  If you had simply mentioned "paging_init() needs to
run first so that the device tree is built and ready" I
wouldn't have even needed to look at your patch :-)
