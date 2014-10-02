From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 02 Oct 2014 00:33:53 +0000
Subject: Re: inconsistent handling of unaligned hash inputs
Message-Id: <20141002003353.GA23780@gondor.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20141001.011034.1533102319982018632.davem@davemloft.net>
In-Reply-To: <20141001.011034.1533102319982018632.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, bpicco@meloft.net, bob.picco@oracle.com, sparclinux@vger.kernel.org

David Miller <davem@davemloft.net> wrote:
>
> Anyways, I suspect that we need to use get_unaligned_be{32,64}() in
> generic SHA256 and SHA512.

The other option is to set cra_alignmask and have the crypto API
handle this.  So the question is what is the cost benefit of using
a normal load vs. get_unaligned_*?

Most in-kernel crypto uses should be using aligned input/output.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
