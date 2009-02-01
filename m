From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sun, 01 Feb 2009 21:59:46 +0000
Subject: Re: make ARCH=sparc allmodconfig change
Message-Id: <20090201220532.GA6567@x200.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20090201190029.GA8962@x200.localdomain>
In-Reply-To: <20090201190029.GA8962@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 01, 2009 at 09:51:13PM +0000, Mark Fortescue wrote:
> Silly question. If ARCH=sparc is not 64bit then how do you make a 32bit  
> sparc kernel?

I ended up with

	$ cat x
	ARCH=sparc
	CROSS_COMPILE=sparc64-unknown-linux-gnu-
	# CONFIG_64BIT is not set

	$ make ARCH=sparc KCONFIG_ALLCONFIG=x allmodconfig
