From: David Miller <davem@davemloft.net>
Date: Sun, 18 Aug 2019 19:39:43 +0000
Subject: Re: sparc64: hang from BUG: Bad page state, on older CPU & compiler
Message-Id: <20190818.123943.1491620523133670968.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
In-Reply-To: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Sun, 18 Aug 2019 00:01:37 -0700

> I think for now we'll simply have to disable HAVE_FAST_GUP for sparc,
> until someone who really knows low-level sparc page table handling
> finds some time to audit the generic fast gup code and arch hooks.

It's a regression, we don't disable features in those circumstances
usually right?
