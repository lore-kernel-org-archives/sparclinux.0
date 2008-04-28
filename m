From: David Miller <davem@davemloft.net>
Date: Mon, 28 Apr 2008 06:37:40 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080427.233740.208119217.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080427.170139.242528272.davem@davemloft.net>
	<20080428062935.GA13876@infradead.org>
In-Reply-To: <20080428062935.GA13876@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@infradead.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 28 Apr 2008 02:29:35 -0400

> Is a WARN_ON the right check for user-triggerable behaviour?  I think
> a normal rate-limited printk with a descriptive text would be better.

I used WARN_ON_ONCE, which I think is sufficient.
