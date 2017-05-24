From: David Howells <dhowells@redhat.com>
Date: Wed, 24 May 2017 13:49:24 +0000
Subject: Re: Unify the various copies of libgcc into lib
Message-Id: <23396.1495633764@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dhowells@redhat.com, monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> ... Unfortunately I don't actually have all these cross compilers setup...

If you have Fedora, you have the following available as standard RPMs:

	gcc-aarch64-linux-gnu
	gcc-alpha-linux-gnu
	gcc-arm-linux-gnu
	gcc-avr32-linux-gnu
	gcc-bfin-linux-gnu
	gcc-c6x-linux-gnu
	gcc-cris-linux-gnu
	gcc-frv-linux-gnu
	gcc-h8300-linux-gnu
	gcc-hppa-linux-gnu
	gcc-hppa64-linux-gnu
	gcc-ia64-linux-gnu
	gcc-m32r-linux-gnu
	gcc-m68k-linux-gnu
	gcc-microblaze-linux-gnu
	gcc-mips64-linux-gnu
	gcc-mn10300-linux-gnu
	gcc-nios2-linux-gnu
	gcc-powerpc64-linux-gnu
	gcc-ppc64-linux-gnu
	gcc-s390x-linux-gnu
	gcc-sh-linux-gnu
	gcc-sparc64-linux-gnu
	gcc-tile-linux-gnu
	gcc-xtensa-linux-gnu

They're built from the same sources as the gcc rpm (and the matching binutils
cross rpms are built from the same sources as the binutils rpm) - it's only
the spec file that's different, and they lag a bit behind the core
gcc/binutils as they only get updated after those change.

So in Fedora 25 these are all gcc-6 and in Fedora 26 they're all gcc-7.

David
