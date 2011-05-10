From: Tkhai Kirill <tkhai@yandex.ru>
Date: Tue, 10 May 2011 23:21:49 +0000
Subject: Re: [PATCH]SPARC32: Fixed unaligned memory copying in function __csum_partial_copy_sparc_generic
Message-Id: <414351305069709@web42.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1304845558.9492.14.camel@big>
In-Reply-To: <1304845558.9492.14.camel@big>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

11.05.11, 00:28, "David Miller" <davem@davemloft.net>:

>I don't understand why you're testing "andcc %o3, %o0, %g0", as %o3 has
>the value computed in "srl %g1, 1, %o3" here.

>What is so interesting about "ptr & (length >> 1)"?

1)Label ccte (rather, cc_end_cruft) copies data sequentially by pieces of length 2^x bytes from biggest to smallest. For example, if %g1 is 15, then the label copies 8+4+2+1, and %o0 must be aligned to 8.

Let alignment a = 2^x. Pointer ptr % a = 0 when:
ptr & (a >> 1) = 0
ptr & (a >> 2) = 0
..

Or, what is the same:
ptr & (length >> 1) = 0
ptr & (length >> 2) = 0
..

I.e. we are looking for right alignment, if another case don't call ccte.

2)We check %o0 only, because %o1 has the same last two bits, and cc_end_cruft writes 4 bytes or less.
