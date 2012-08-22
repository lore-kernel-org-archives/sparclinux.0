From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 22 Aug 2012 13:40:40 +0000
Subject: Re: [PATCH] sparc64: Add AES driver making use of the new aes opcodes.
Message-Id: <20120822134040.GA7440@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20120822.022118.64713091452626424.davem@davemloft.net>
In-Reply-To: <20120822.022118.64713091452626424.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-crypto@vger.kernel.org

On Wed, Aug 22, 2012 at 02:21:18AM -0700, David Miller wrote:
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Nice work!

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
 
> Finally I'll probably add support at some point for the crc32c
> instruction as well.

That would be very useful, much more so than Kasumi :)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
