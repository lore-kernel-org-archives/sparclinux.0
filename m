From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 13 Jan 2017 14:37:18 +0000
Subject: Re: [PATCH 0/4] n2rng: add support for m5/m7 rng register layout
Message-Id: <20170113143718.GB26101@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <1484247169-245086-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1484247169-245086-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shannon Nelson <shannon.nelson@oracle.com>
Cc: linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 12, 2017 at 10:52:45AM -0800, Shannon Nelson wrote:
> Commit c1e9b3b0eea1 ("hwrng: n2 - Attach on T5/M5, T7/M7 SPARC CPUs")
> added config strings to enable the random number generator in the sparc
> m5 and m7 platforms.  This worked fine for client LDoms, but not for the
> primary LDom, or running on bare metal, because the actual rng hardware
> layout changed and self-test would now fail, continually spewing error
> messages on the console.
> 
> This patch series adds correct support for the new rng register layout,
> and adds a limiter to the spewing of error messages.

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
