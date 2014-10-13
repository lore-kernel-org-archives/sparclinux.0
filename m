From: David Miller <davem@davemloft.net>
Date: Mon, 13 Oct 2014 03:53:09 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141012.235309.340235317786810033.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 22:57:12 -0400 (EDT)

> I can reproduce this AES failure as well as the unaligned accesses.

I've figured out the nature of the AES failure.

The code tries to optimize the case of processing many blocks at a
time, by preloading the KEY material into the FPU registers then
running the encrypt/decrypt routine over and over again reusing
those precooked registers.

Somehow it appears that the pre-cooked key registers get spammed
upon.  Even if we get an intervening memcpy() via the blkcipher*()
calls, we fully support recursive FPU usage in the kernel on sparc64
so it should "just work".

The test case passes if I change the ->ecb_encrypt() call in
ctr_crypt_final() to ->encrypt() (which hand loads the key into the
FPU before performing a single block encrypt).

Anyways I'll dig further and fix this.
