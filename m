From: David Miller <davem@davemloft.net>
Date: Wed, 27 May 2009 05:35:36 +0000
Subject: Re: [PATCH 5/12]: sparc64: Refactor OBP cpu scanning code using an
Message-Id: <20090526.223536.12323520.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408.223738.63750701.davem@davemloft.net>
	<20090409062924.GA14255@uranus.ravnborg.org>
In-Reply-To: <20090409062924.GA14255@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: tj@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 9 Apr 2009 08:29:24 +0200

> You never pass a "void *" as argument to this iterator.
> It seems cleaner to use a long or even an int as this is closer
> to the typical usage, and one can always pass a '0' when the
> argument is not used.

I've changed this to an 'int' while respinning this patch.

Thanks!
