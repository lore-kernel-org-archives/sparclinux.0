From: David Miller <davem@davemloft.net>
Date: Thu, 02 Oct 2014 01:06:14 +0000
Subject: Re: inconsistent handling of unaligned hash inputs
Message-Id: <20141001.180614.1843735881125772362.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141001.011034.1533102319982018632.davem@davemloft.net>
	<20141002003353.GA23780@gondor.apana.org.au>
In-Reply-To: <20141002003353.GA23780@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, bpicco@meloft.net, bob.picco@oracle.com, sparclinux@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 2 Oct 2014 08:33:53 +0800

> David Miller <davem@davemloft.net> wrote:
>>
>> Anyways, I suspect that we need to use get_unaligned_be{32,64}() in
>> generic SHA256 and SHA512.
> 
> The other option is to set cra_alignmask and have the crypto API
> handle this.  So the question is what is the cost benefit of using
> a normal load vs. get_unaligned_*?
> 
> Most in-kernel crypto uses should be using aligned input/output.
> 

In these specific hash functions we only read the u32/u64 inputs
a byte at a time once, to get them into the work buffer.

If we have the crypto layer do it, we'll bounce the data around
once to the crypto layer bounce buffer, then once again into
the hash implementation's work buffer.

I think it's better to avoid the extra copy right?
