From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 31 Aug 2004 17:00:15 +0000
Subject: Re: [parisc-linux] [PATCH] New error codes for Alpha, MIPS,
Message-Id: <1093971614.599.20.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20040830232445.0b5aad79.akpm@osdl.org>
	 <13071.1093965134@redhat.com>
In-Reply-To: <13071.1093965134@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, rth@twiddle.net, linux-mips@linux-mips.org, HPPA List <parisc-linux@parisc-linux.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Maw, 2004-08-31 at 16:12, David Howells wrote:
> The attached patch adds the new error codes I added for key-related errors to
> those archs that don't make use of <asm-generic/errno.h>, including Alpha,
> MIPS, PA-RISC, Sparc and Sparc64. This is required to compile with CONFIG_KEYS
> on those platforms.

The patch seems to be mixing the fixups for remapping these error codes
into sparc, hpux, osf/1 and other compatibility layers on the platforms

