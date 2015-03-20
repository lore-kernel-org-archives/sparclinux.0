From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 19:47:00 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150320.154700.1250039074828760104.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <550C5078.8040402@oracle.com>
	<CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
	<550C6151.8070803@oracle.com>
In-Reply-To: <550C6151.8070803@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: torvalds@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Fri, 20 Mar 2015 12:05:05 -0600

> DaveM: do you mind if I submit a patch to change the default for sparc
> to SLUB?

I think we're jumping the gun about all of this, and doing anything
with default Kconfig settings would be entirely premature until we
know what the real bug is.

On my T4-2 I've used nothing but SLAB and haven't hit any of these
problems.  I can't even remember the last time I turned SLUB on,
and it's just because I'm lazy.
