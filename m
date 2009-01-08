From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 08 Jan 2009 22:20:46 +0000
Subject: Re: [PATCH v2 0/5] Eliminate most of sparc_ksyms_*.c
Message-Id: <200901082320.47056.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1C6.1090700@gmail.com>
In-Reply-To: <4965F1C6.1090700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 08 January 2009, Sam Ravnborg wrote:
> Arnd Bergman once posted a patchset that allow us to do the export in .S files.
> 
> Google for "add support for exporting symbols from .S files"
> 
> Could we resurface this patchset?

The patch should still work. The only concern with this was that it
still isn't sufficient to kill ksyms.c on architectures that export
symbols from libgcc.

	Arnd <><
