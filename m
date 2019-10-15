From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 15 Oct 2019 16:25:39 +0000
Subject: Re: [RFT PATCH 0/3] crypto: sparc - convert to skcipher API
Message-Id: <20191015162539.GA852@sol.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20191012043850.340957-1-ebiggers@kernel.org>
 <20191015081138.GA23837@infradead.org>
In-Reply-To: <20191015081138.GA23837@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

On Tue, Oct 15, 2019 at 01:11:38AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 09:38:47PM -0700, Eric Biggers wrote:
> > This series converts the glue code for the SPARC64 crypto opcodes
> > implementations of AES, Camellia, DES, and 3DES modes from the
> > deprecated "blkcipher" API to the "skcipher" API.  This is needed in
> > order for the blkcipher API to be removed.
> 
> Not knowing much about the API: do you have an explanation of what the
> difference is and why it matters?
> 

They're all APIs for length-preserving encryption algorithms, but the skcipher
API has some improvements, such as:

    - a much less confusing name
    - better type safety (skcipher_alg, crypto_skcipher, etc. instead of
      crypto_alg, crypto_tfm, etc.)
    - optional support for asynchronous operation (like "ablkcipher")
    - optional support per request-contexts (like "ablkcipher")
    - simpler scatterlist walks for some algorithms

The skcipher API was introduced in 2015 to replace blkcipher and ablkcipher, and
most implementations and almost all API users were converted.  But some
implementations weren't converted, so the crypto subsystem still has to carry
all the blkcipher and ablkcipher compatibility code, as well as all
documentation for blkcipher and ablkcipher.  This is really confusing for people
working with the crypto API, and bad for testing as there's no easy way to test
{,a}blkcipher on x86, arm, or arm64 anymore.  So, Ard and I are finishing the
conversions so that blkcipher and ablkcipher can finally be removed.

- Eric
