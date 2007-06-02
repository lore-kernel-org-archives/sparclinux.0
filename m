From: David Miller <davem@davemloft.net>
Date: Sat, 02 Jun 2007 20:09:44 +0000
Subject: Re: Alignment question, sparc-centric
Message-Id: <20070602.130944.74730726.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 2 Jun 2007 19:46:21 +0100 (BST)

> Some versions of GCC may be capable of sorting out the correct code
> but my experience is avoid the situation to start with by using code
> similar to memcpy (&x, &un_aligned_x, sizeof x).

This unfortunately doesn't work, if GCC decides the object is
small enough to copy inline, it will emit 32-bit and 64-bit
load and store instructions and still therefore take the
unaligned exceptions.

Types must be aligned on their natural size, and GCC can assume
this everywhere you reference such types unless you use the
"packed" GCC attribute.
