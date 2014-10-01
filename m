From: David Miller <davem@davemloft.net>
Date: Wed, 01 Oct 2014 02:57:12 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140930.225712.1895088212952315365.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 22:29:00 -0400 (EDT)

> From: Bob Picco <bpicco@meloft.net>
> Date: Tue, 30 Sep 2014 18:28:41 -0400
> 
>> aes_sparc64: Using sparc64 aes opcodes optimized AES implementation
>> alg: skcipher-ddst: Test 5 failed on encryption for ctr-aes-sparc64
>> 00000000: da 4e 3f bc e8 b6 3a a2 d5 4d 84 4a a9 0c e1 a5
> 
> Hmmm, interesting.  I just noticed that I haven't enabled the
> sparc64 crypto drivers in my current test .config, but I
> turned them on and I don't get this test failure.
> 
> I'll try to reproduce with the 'tcrypt' module or similar.

I don't see it because my config has CRYPTO_MANAGER_DISABLE_TESTS set,
which is the default :-/

I can reproduce this AES failure as well as the unaligned accesses.
