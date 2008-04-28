From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 28 Apr 2008 06:29:35 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080428062935.GA13876@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080427.170139.242528272.davem@davemloft.net>
In-Reply-To: <20080427.170139.242528272.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Apr 27, 2008 at 05:01:39PM -0700, David Miller wrote:
> 
> Several fixes and cleanups:
> 
> 1) Remove SunOS signal frame support, that Linux used for like
>    a month some 12 years ago :-)  I added an assertion that checks
>    to make sure 32-bit processes request the newer style signal
>    frames, which I doubt will ever trigger since Jakub Jelinek
>    and myself are probably the only two people on the planet who
>    ever had such Linux binaries on their system :-)

Is a WARN_ON the right check for user-triggerable behaviour?  I think
a normal rate-limited printk with a descriptive text would be better.

>    Getting rid of the EBUS layer is much hardware, and will require

					  harder? :)

