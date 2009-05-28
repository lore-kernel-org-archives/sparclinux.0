From: David Miller <davem@davemloft.net>
Date: Thu, 28 May 2009 22:00:30 +0000
Subject: Re: silo on qemu-system-sparc64
Message-Id: <20090528.150030.65740814.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <b2fa41d60905271347g252290b1s2809233b081c95af@mail.gmail.com>
In-Reply-To: <b2fa41d60905271347g252290b1s2809233b081c95af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Igor Kovalenko <igor.v.kovalenko@gmail.com>
Date: Thu, 28 May 2009 23:10:12 +0400

> By the way, currently we cannot use unoptimized openbios
> builds with linux kernel because there is not enough space
> for unoptimized code to store arguments. Kernel stores
> arguments array in 128 bytes below stack frame whereas
> at least 192 bytes are needed.
> 
> Do you think it makes sense to increase that 128 to 192 ?

I don't think this is going to change, sorry.

I even have plans to make GCC always use a 128 byte stack frame unless
varargs are being used, via a special GCC command line option like
-mkernel or similar.

There is no reason to pop arguments into that argument save area in
the stack frame, unless varargs are being used.

This is assuming I understand what you're talking about. :-)

