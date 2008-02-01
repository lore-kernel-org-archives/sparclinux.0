From: David Miller <davem@davemloft.net>
Date: Fri, 01 Feb 2008 00:49:06 +0000
Subject: Re: [PATCH][SPARC64] fix inconsistent .section usage in lib/
Message-Id: <20080131.164906.136001703.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 Jan 2008 13:56:23 +0100

> A few places missed the "a" specifier for
> the __ex_table section. Add these
> so we avoid generation an additional
> section at link time.
> 
> Latest modpost would otherwise complain
> like this:
> 
> WARNING: vmlinux.o (__ex_table.2): section name inconsistency.
> (.[number]+) following section name.
> Did you forget to use "ax"/"aw" in a .S file?
> Note that for example <linux/init.h> contains
> section definitions for use in .S files.
> WARNING: vmlinux.o (__ex_table.4): section name inconsistency.
> (.[number]+) following section name.
> Did you forget to use "ax"/"aw" in a .S file?
> Note that for example <linux/init.h> contains
> section definitions for use in .S files.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.
