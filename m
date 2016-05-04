From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 04 May 2016 04:07:32 +0000
Subject: Re: [crypto / sparc64] cryptomgr_test OOPS
Message-Id: <20160504040731.GA25758@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20160503.123301.298039059390449291.davem@davemloft.net>
In-Reply-To: <20160503.123301.298039059390449291.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: matorola@gmail.com, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, Nicolai Stange <nicstange@gmail.com>

David Miller <davem@davemloft.net> wrote:
> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Tue, 3 May 2016 16:54:18 +0300
> 
>> I have git kernel OOPS (4.6.0-rc6) on sparc64. This OOPS does not
>> happen, if I set the following kernel option:
>> 
>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
>> 
>> Can someone please look at https://bugzilla.kernel.org/show_bug.cgi?id7551 ?
> 
> The lib/mpi/ code hasn't been touched in a long time, so I can only see that it might
> be the crypto/rsa.c changes that happened this release.
> 
> Can you possibly bisect this or at least tell us that 4.5 doesn't have this problem?

It would also be helpful to test the latest cryptodev tree which
has a large number of MPI fixes from Nicolai Stange.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
