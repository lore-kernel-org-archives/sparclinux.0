From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Thu, 06 Dec 2007 22:31:37 +0000
Subject: Re: SunOS/Solaris Binary Emulation
Message-Id: <Pine.LNX.4.64.0712062331051.1262@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <475825D7.1090209@dalsemi.com>
In-Reply-To: <475825D7.1090209@dalsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Dec 6 2007 12:15, Wes Hardin wrote:
>
> assuming I'm reading the output of readelf correctly, the only shared library
> mentioned is libc.so.1
>
> manhack:/usr/gnemul/solaris# readelf -d bin/uname
>
> Dynamic section at offset 0x14b8 contains 22 entries:
> Tag        Type                         Name/Value
> 0x00000001 (NEEDED)                     Shared library: [libc.so.1]
>
> which is already copied over.

Hm, perhaps ld.so (which should definitely exist on any ELF system)
is not listed by readelf, but I guess it's needed anyway.

