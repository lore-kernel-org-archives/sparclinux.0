From: David Miller <davem@davemloft.net>
Date: Fri, 25 Aug 2006 23:22:40 +0000
Subject: Re: [PATCH] sparc32: small smp cleanup
Message-Id: <20060825.162240.124268925.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44ddd664b387e@wp.pl>
In-Reply-To: <44ddd664b387e@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 12 Aug 2006 15:23:48 +0200

> From: Krzysztof Helt (krzysztof.h1@wp.pl)
> 
> It moves the smp_procesors_ready variable to sun4d_smp.c only.
> 
> Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
> ---
> smp_processors_ready is not really used in sun4m_smp.c. Let the
> sun4d guys remove it.
> 
> I tested it on SS20 and 2.6.18-rc4 kernel.

Applied, except I added "static" to the instance you left
in sun4d_smp.c
