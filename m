From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 19:21:18 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <alpine.LSU.2.01.0912222017460.18129@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tuesday 2009-12-22 20:09, David Miller wrote:
>
>> Seems Debian's glibc is also affected:
>
>Jan I showed you how I ran your test program on my Debian
>system and it worked fine.
>Show me the output from your program on the Debian systems
>where you claim it is also broken.  That way we can compare
>notes, just showing the glibc version output doesn't help
>me.

Well just send me your compiled binary over and I'll figure
out the rest eventually. I am not running Debian at this time -
system is still stuck in F12. But if you know how to set up
LDOM, I could :)

>> Assume there's a scientific program needing >4GB address space, so I
>> need at least _a little_ 64-bit.
>
>'tar' is a scientific program needing >4GB address space? :)

No. tar belongs to the buildroot like gcc.



Jan
