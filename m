From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Wed, 17 Dec 2008 01:22:26 +0000
Subject: Re: Compiling glibc with 2.6.28 linux headers
Message-Id: <1229476946.6481.0.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
References: <4943DAD6.7070402@gentoo.org>
	 <20081216.011334.124918024.davem@davemloft.net>
In-Reply-To: <20081216.011334.124918024.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: bluebird@gentoo.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2008-12-16 at 01:13 -0800, David Miller wrote:
> From: Friedrich Oslage <bluebird@gentoo.org>
> Date: Sat, 13 Dec 2008 16:55:02 +0100
> 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Hi,
> > 
> > when compiling glibc(2.9, 20081208 snapshot) with linux 2.6.28-rc8
> > headers I get a lot of errors like this one:
> > 
> > In file included from
> > /tmp/toolchain-build/rootfs/usr/include/asm/byteorder.h:49,
> >                  from
> > /tmp/toolchain-build/rootfs/usr/include/linux/atalk.h:4,
> >                  from ../sysdeps/unix/sysv/linux/netatalk/at.h:25,
> >                  from ../sysdeps/unix/sysv/linux/sa_len.c:22:
> > /tmp/toolchain-build/rootfs/usr/include/linux/byteorder.h:8:3: error:
> > #error Fix asm/byteorder.h to define one endianness
> 
> Harvey, we might need to do something about this.

I'm on the run today, will take a look in 24 hours.

Harvey

