From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 06 Sep 2012 19:49:31 +0000
Subject: Re: [PATCH 0/5] sparc64: AES driver improvements
Message-Id: <20120906194931.GB22661@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20120830.114555.1966388095294836244.davem@davemloft.net>
In-Reply-To: <20120830.114555.1966388095294836244.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-crypto@vger.kernel.org

On Thu, Aug 30, 2012 at 11:45:55AM -0400, David Miller wrote:
> 
> This patch series adds CTR mode support to the sparc64 AES driver
> and then unrolls the loops that we can to get better performance.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Nice work :)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
