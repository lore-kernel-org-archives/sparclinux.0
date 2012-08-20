From: David Miller <davem@davemloft.net>
Date: Mon, 20 Aug 2012 22:07:54 +0000
Subject: Re: [PATCH 0/4] Crytpo hash drivers for sparc64 crypto instructions.
Message-Id: <20120820.150754.1866106456418899305.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120819.221000.1440395237780126787.davem@davemloft.net>
	<20120820082202.GC22529@gondor.apana.org.au>
In-Reply-To: <20120820082202.GC22529@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herbert@gondor.apana.org.au
Cc: sparclinux@vger.kernel.org, linux-crypto@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 20 Aug 2012 16:22:02 +0800

> On Sun, Aug 19, 2012 at 10:10:00PM -0700, David Miller wrote:
>> 
>> SPARC-T4 and later support cryptographic instructions.
>> 
>> This patch series adds support for the hash digest algorithms.
>> 
>> This includes md5, sha1, sha224, sha256, sha384, and sha512.
>> 
>> Herbert, this depends upon sparc64 cpu feature detection
>> infrastructure that is going in via the sparc-next tree, so I intend
>> to commit this work there if you don't mind.
>> 
>> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Thanks! Looks good to me.

Thanks for reviewing.
