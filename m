From: David Miller <davem@davemloft.net>
Date: Tue, 22 Dec 2009 19:11:12 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <20091222.111112.226770729.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 16:21:57 +0100 (CET)

> As far as I can tell, sparcv9v packages are not created in an
> sparcv9-incompatible way.
> 
> $ grep -r niagara /usr/lib/rpm
> /usr/lib/rpm/rpmrc:optflags: sparcv9v -O2 -g -m32 -mtune=niagara
> /usr/lib/rpm/rpmrc:optflags: sparc64v -O2 -g -m64 -mtune=niagara
> 
> It only uses -mtune, not -mcpu. Or did I err somewhere in this regard?

-mcpu with sparc64 chip names would turn on 64-bit code generation.
Or at least, it did at one point.
