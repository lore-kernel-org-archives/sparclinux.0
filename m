From: David Miller <davem@davemloft.net>
Date: Sat, 19 May 2007 19:04:56 +0000
Subject: Re: [PATCH] sunzilog: section mismatch fix
Message-Id: <20070519.120456.85409628.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <465089A2.4080401@wp.pl>
In-Reply-To: <465089A2.4080401@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 20 May 2007 19:47:14 +0200

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes section mismatch warnings in the sunzilog driver.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Your patch was space and tab corrupted so I had to apply
this patch by hand.

Seeing how you used an attachment for the previous patch,
it's clear why this one was corrupt because you inlined
it instead of attaching.
