From: David Miller <davem@davemloft.net>
Date: Fri, 10 Jun 2016 17:43:47 +0000
Subject: Re: [PATCH v4 39/44] sparc: dma-mapping: Use unsigned long for dma_attrs
Message-Id: <20160610.104347.27574417059803210.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
	<1465553521-27303-40-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1465553521-27303-40-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: k.kozlowski@samsung.com
Cc: akpm@linux-foundation.org, hch@infradead.org, b.zolnierkie@samsung.com, julian.calaby@gmail.com, adam.buchbinder@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 10 Jun 2016 12:11:56 +0200

> Split out subsystem specific changes for easier reviews. This will be
> squashed with main commit.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

If you split the method signatures from the type changes to the pointers
that they are assigned to, this breaks bisection.

You have to change them all at once, or use some other transitional
mechanism for the intervening changes.
