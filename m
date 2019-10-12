From: David Miller <davem@davemloft.net>
Date: Sat, 12 Oct 2019 05:12:53 +0000
Subject: Re: [RFT PATCH 0/3] crypto: sparc - convert to skcipher API
Message-Id: <20191011.221253.1698497015931303703.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20191012043850.340957-1-ebiggers@kernel.org>
In-Reply-To: <20191012043850.340957-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ebiggers@kernel.org
Cc: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org

From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 11 Oct 2019 21:38:47 -0700

> I've compiled this patchset, and the conversion is very similar to that
> which has been done for many other crypto drivers.  But I don't have the
> hardware to test it, nor are SPARC64 crypto opcodes supported by QEMU.
> So I really need someone with the hardware to test it.  You can do so by
> setting:

Eric, I'll try to test this for you over the weekend.
