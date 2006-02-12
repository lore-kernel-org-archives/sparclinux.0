From: Al Viro <viro@ftp.linux.org.uk>
Date: Sun, 12 Feb 2006 00:21:14 +0000
Subject: Re: [PATCH] sparc32: Fix div, udiv, mul, umul, rem, urem breakage
Message-Id: <20060212002114.GS27946@ftp.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20060211113817.GA25564@palantir8>
In-Reply-To: <20060211113817.GA25564@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 12, 2006 at 10:54:37AM +1100, Rusty Russell wrote:
> It seems so, as Al so comprehensively explained.  It was binutils
> breakage.  You might find something like this (note: untested!)
> preferable.  Other archs may well want EXPORT_SYMBOL_AS for special
> effects anyway.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Make sparc use the same "remove the dot" mangling as other archs, which
> depmod already understands.  Avoid namespace pollution (not really a
> problem, but ugly) by using an __export_ alias: it needs to be a global
> symbol as attempts to craft an alias in the sparc_ksyms.c was rejected
> by various recent binutils versions:

ewww...

You do realize that your "remove the dot" is ppc-only?  I.e. just as much
of a special case as sparc-only mapping.

Seriously, fix in depmod is considerably smaller that what you've just
posted, not to mention being conceptually simpler.
