From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 15 Oct 2019 08:11:38 +0000
Subject: Re: [RFT PATCH 0/3] crypto: sparc - convert to skcipher API
Message-Id: <20191015081138.GA23837@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20191012043850.340957-1-ebiggers@kernel.org>
In-Reply-To: <20191012043850.340957-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

On Fri, Oct 11, 2019 at 09:38:47PM -0700, Eric Biggers wrote:
> This series converts the glue code for the SPARC64 crypto opcodes
> implementations of AES, Camellia, DES, and 3DES modes from the
> deprecated "blkcipher" API to the "skcipher" API.  This is needed in
> order for the blkcipher API to be removed.

Not knowing much about the API: do you have an explanation of what the
difference is and why it matters?

>  arch/sparc/crypto/aes_glue.c      | 310 +++++++++----------
>  arch/sparc/crypto/camellia_glue.c | 217 ++++++-------
>  arch/sparc/crypto/des_glue.c      | 499 ++++++++++++++----------------
>  crypto/Kconfig                    |   5 +-
>  4 files changed, 468 insertions(+), 563 deletions(-)

At least it removes more code than it adds, which always is a good
thing.
