From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 29 May 2016 17:30:38 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <20160529173038.GA31518@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160527.123731.2105286005500436503.davem@davemloft.net>
 <8760tz2n1j.fsf@esperi.org.uk>
 <20160527.155137.1489438133864702237.davem@davemloft.net>
 <20160528.212420.136855725029412782.davem@davemloft.net>
In-Reply-To: <20160528.212420.136855725029412782.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

Hi Dave.

> Ok, mystery solved.

Super good explanation...
> 
> ==========
> >From d645a0376b0010cd60ae5651b3b84a56f5b0e5a4 Mon Sep 17 00:00:00 2001
> From: "David S. Miller" <davem@davemloft.net>
> Date: Sat, 28 May 2016 20:41:12 -0700
> Subject: [PATCH 2/2] sparc64: Fix return from trap window fill crashes.
> 
> We must handle data access exception as well as memory address unaligned
> exceptions from return from trap window fill faults, not just normal
> TLB misses.

It would be nice to include the explanation from the mail in the changelog.
It gives a good background information and it is more accessible in the
commit log rather than mails only.

	Sam
