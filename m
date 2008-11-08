From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 08 Nov 2008 08:41:28 +0000
Subject: Re: sparc boot failure
Message-Id: <20081108084128.GA24322@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <49125E98.8070905@earthlink.net>
In-Reply-To: <49125E98.8070905@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Robert.

> The second patch doesn't compile.  The attached patch does but it 
> doesn't boot because the kernel is now too big to load.
> 
> The size of vmlinux went from 4632210 to 4946070.

Can you send me your config so I can see why this size increase happens.
defconfig did not build with my sparc toolchain.

Did you have any mods in head.S too?

[I know davem are planning to revert the offending patch, but I would like
to understand this size increase anyway]


	Sam
