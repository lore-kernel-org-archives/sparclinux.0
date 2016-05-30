From: David Miller <davem@davemloft.net>
Date: Mon, 30 May 2016 02:15:55 +0000
Subject: Re: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-
Message-Id: <20160529.191555.2253154253641402121.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160527.155137.1489438133864702237.davem@davemloft.net>
	<20160528.212420.136855725029412782.davem@davemloft.net>
	<20160529173038.GA31518@ravnborg.org>
In-Reply-To: <20160529173038.GA31518@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, fweimer@redhat.com

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 29 May 2016 19:30:38 +0200

> It would be nice to include the explanation from the mail in the changelog.
> It gives a good background information and it is more accessible in the
> commit log rather than mails only.

Yep, will supplement the commit message as well as include the backtraces
and reported-by: tags for Nick.
