From: David Miller <davem@davemloft.net>
Date: Fri, 18 Sep 2009 00:31:54 +0000
Subject: Re: [PATCH] fix BUILD_BUG_ON() and a couple of bogus uses of it
Message-Id: <20090917.173154.100425957.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090917162437.b1a890de.akpm@linux-foundation.org>
	<20090917.170156.152594715.davem@davemloft.net>
	<20090917171504.649ba29b.akpm@linux-foundation.org>
In-Reply-To: <20090917171504.649ba29b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: JBeulich@novell.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 17 Sep 2009 17:15:04 -0700

> There's a shortcoming in the current BUILD_BUG_ON() - it silently does
> nothing if passed a non-constant arg.
> 
> I suspect that in the 2.6.31 code, that BUILD_BUG_ON() just does
> nothing at all, and that Jan's patch is now exposing this.  It might be
> compiler-version dependent too.
> 
> 
> <tests it>
> 
> Yup, on base 2.6.31, this:

Ok, I'll have to either change this function to a macro or
get rid of the check.

Thanks.
