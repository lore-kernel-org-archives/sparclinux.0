From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Fri, 27 Aug 2004 20:05:12 +0000
Subject: Re: [sparc32] unversioned udiv taints kernel
Message-Id: <20040827200512.GA4743@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cgo1li$t40$1@sea.gmane.org>
In-Reply-To: <cgo1li$t40$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Aug 27, 2004 at 12:22:22PM -0700, Joshua Kwan wrote:

> $ dmesg | grep udiv
> scsi_mod: no version for "udiv" found: kernel tainted.
> 
> This is the only such occurrence. arch/sparc/kernel/sparc_ksyms.c says:
> 
> EXPORT_SYMBOL(udiv);
> 
> Christoph Hellwig suggested EXPORT_SYMBOL_NOVERS but:
> 
> /* We don't mangle the actual symbol anymore, so no need for
>  * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
> #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
> 
> What's the right way to fix this?

The versioning method has changed; all symbols are versioned now using
a different method.  I believe I had fixed this quite a while ago -
check the bk logs.  What kernel are you using?

-- 
Keith M Wesolowski
"Site launched. Many things not yet working." --Hector Urtubia
