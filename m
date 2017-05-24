From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 24 May 2017 13:59:50 +0000
Subject: Re: Unify the various copies of libgcc into lib
Message-Id: <20170524135950.GB4230@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <23396.1495633764@warthog.procyon.org.uk>
In-Reply-To: <23396.1495633764@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, May 24, 2017 at 02:49:24PM +0100, David Howells wrote:
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
> 
> > ... Unfortunately I don't actually have all these cross compilers setup...
> 
> If you have Fedora, you have the following available as standard
> RPMs:

And if you need more than just the cross-compilers (e.g. libraries for
the target architecture), I recommend a Debian Stretch or newer.

Debian's Multi-Arch allows one to install libraries for the target
system onto your build system. I have used that extensively in the
past, for example to bootstrap GHC for various architectures [1].

Adrian

> [1] https://wiki.debian.org/PortsDocs/BootstrappingGHC

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
