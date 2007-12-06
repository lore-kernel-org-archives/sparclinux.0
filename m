From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Thu, 06 Dec 2007 17:32:00 +0000
Subject: Re: SunOS/Solaris Binary Emulation
Message-Id: <Pine.LNX.4.64.0712061829580.27032@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <475825D7.1090209@dalsemi.com>
In-Reply-To: <475825D7.1090209@dalsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Dec 6 2007 10:39, Wes Hardin wrote:
>
> manhack:/usr/gnemul/solaris/bin# file ./uname
> ./uname: ELF 32-bit MSB executable, SPARC, version 1 (SYSV), dynamically linked
> (uses shared libs), stripped
> manhack:/usr/gnemul/solaris/bin# ./uname
> -bash: ./uname: No such file or directory
>
> I don't know if the Linux ldd is supposed to work on these binaries, but it
> doesn't:
>
> manhack:/usr/gnemul/solaris/bin# ldd ./uname
> /usr/bin/ldd: line 117: ./uname: No such file or directory

I suppose you need the Solaris libraries too, including dynamic
linker. See output of `readelf -d uname`.
