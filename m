From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 10 Jun 2016 20:03:25 +0000
Subject: Re: [PATCH v4 39/44] sparc: dma-mapping: Use unsigned long for dma_attrs
Message-Id: <20160610200325.GA2235@kozik-lap>
List-Id: <sparclinux.vger.kernel.org>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
 <1465553521-27303-40-git-send-email-k.kozlowski@samsung.com>
 <20160610.104347.27574417059803210.davem@davemloft.net>
In-Reply-To: <20160610.104347.27574417059803210.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: k.kozlowski@samsung.com, akpm@linux-foundation.org, hch@infradead.org, b.zolnierkie@samsung.com, julian.calaby@gmail.com, adam.buchbinder@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 10, 2016 at 10:43:47AM -0700, David Miller wrote:
> From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Date: Fri, 10 Jun 2016 12:11:56 +0200
> 
> > Split out subsystem specific changes for easier reviews. This will be
> > squashed with main commit.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> If you split the method signatures from the type changes to the pointers
> that they are assigned to, this breaks bisection.
> 
> You have to change them all at once, or use some other transitional
> mechanism for the intervening changes.

Yes, this is why I wrote the commit message above. The split here is only
for making code review easier for respective maintainers.

All these smaller patches will be squashed together with the main commit
(patch 1/44 [1] [2]). Unfortunately the CC-list would be too huge to
send it to all maintainers.

Best regards,
Krzysztof

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1164335.html
[2] https://github.com/krzk/linux/commit/72dee332b0bedb5cbfc51646d3c03ecbc4a5fe1e
