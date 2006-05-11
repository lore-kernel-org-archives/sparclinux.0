From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 11 May 2006 19:21:00 +0000
Subject: Re: [PATCH] sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060511.122100.82015093.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060511180731.GB16957@palantir8>
In-Reply-To: <20060511180731.GB16957@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 11 May 2006 19:07:32 +0100

> +		case R_SPARC_UA32:	/* Like R_SPARC_32 but unaligned */
> +			uv = (u8 *) v;
> +			location[0] = uv[0];
> +			location[1] = uv[1];
> +			location[2] = uv[2];
> +			location[3] = uv[3];
> +			break;
> +

This is not correct.

The relocation puts "value v" at "location" not "data at address v" at
"location", the latter of which is what your patch is trying to do.

Simply adding "case R_SPARC_UA32:" right under "case R_SPARC_32:"
would work just fine since the R_SPARC_32 code already handles
arbitrary alignment of "location" which is the crucial difference
between R_SPARC_32 and R_SPARC_UA32.

I still wonder where you're getting that relocation from.  It must be
emitted by some dwarf2 frame unwind stuff.  It's a shame that such
bloat is aparently being emitted into objects by default.

Can you send me a sample object that has such a relocation again?  I
don't want to add support for this relocation if it really is not
needed.  I'm hoping we can add a compiler option that will make this
cruft not get output by the compiler since it is superfluous and of
no use in the kernel build.

Thanks.
