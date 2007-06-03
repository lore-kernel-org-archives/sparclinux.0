From: "Bernhard R. Link" <brlink@debian.org>
Date: Sun, 03 Jun 2007 10:14:09 +0000
Subject: Re: Alignment question, sparc-centric
Message-Id: <20070603101409.GB8927@pcpool00.mathematik.uni-freiburg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* David Miller <davem@davemloft.net> [070602 22:09]:
> Types must be aligned on their natural size, and GCC can assume
> this everywhere you reference such types unless you use the
> "packed" GCC attribute.

And even with packed, the struct itself must be naturally aligned
(unless itself is in a packed struct, if course).
Funny example (I think from some dhcp-client):
Make a packed struct with an 32 bit value on a 4*n+2 address,
and (illegally[1] since it's the wrong alignment) cast a char pointer
to an 4*m+2 address. Then the 32 bit value will be at an double even
address. But as gcc may optimize for a 4*m address of the struct,
it will even optimize a memcpy for that field away, replacing it with
loads of the (only presumed) double-even addresses before and after
and code to combine them. Thus you get a bus error for accessing a
32 bit value at an double-even address, because the struct it was in
was not.

Hochachtungsvoll,
	Bernhard R. Link

[1] for proper values of "illegal". I guess that will only be
something triggering undefined behaviour, not any other meaning
of illegal.
