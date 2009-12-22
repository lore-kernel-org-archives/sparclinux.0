From: David Miller <davem@davemloft.net>
Date: Tue, 22 Dec 2009 19:09:50 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <20091222.110950.193712963.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 15:38:44 +0100 (CET)

> Seems Debian's glibc is also affected:

Jan I showed you how I ran your test program on my Debian
system and it worked fine.

Show me the output from your program on the Debian systems
where you claim it is also broken.  That way we can compare
notes, just showing the glibc version output doesn't help
me.

> Assume there's a scientific program needing >4GB address space, so I
> need at least _a little_ 64-bit.

'tar' is a scientific program needing >4GB address space? :)

> Well yes, call it testing. Apparently, I found a bug.
> So mission accomplished :-)

That indeed does make sense and is good :-)
