From: David Miller <davem@davemloft.net>
Date: Thu, 20 Feb 2014 00:47:13 +0000
Subject: Re: [PATCH 2/4] Sparc: sparc_cpu_model isn't in asm/system.h any more
Message-Id: <20140219.194713.1411547109743205257.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140212154544.2405.2992.stgit@warthog.procyon.org.uk>
	<20140212154559.2405.3104.stgit@warthog.procyon.org.uk>
In-Reply-To: <20140212154559.2405.3104.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dhowells@redhat.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Wed, 12 Feb 2014 15:45:59 +0000

> sparc_cpu_model isn't in asm/system.h any more, so remove a comment about it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

That's not all your patch does:

> -	/* extern enum sparc_cpu sparc_cpu_model; */ /* in <asm/system.h> */
> -	if (sparc_cpu_model != sun4m) {
> +	if (sparc_cpu_model != sun4m)
>  		/* We must be on sun4m because we use MMU Bypass ASI. */
>  		return -ENXIO;
> -	}

The basic block is more than one line, therefore the braces are
appropriate.  Please do not remove them, and especially do not
remove them without mentioning them in the commit message.

Thanks.
