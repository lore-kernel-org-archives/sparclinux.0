From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 02:12:45 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20100817.191245.112612004.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100817.180325.104051399.davem@davemloft.net>
	<AANLkTikQ1dGw0aO10_ZwmVEc-JAVhB==3HS7SrWycE49@mail.gmail.com>
In-Reply-To: <AANLkTikQ1dGw0aO10_ZwmVEc-JAVhB==3HS7SrWycE49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Aug 2010 18:31:50 -0700

> Confused yet?

Beyond...

> The basic rule becomes: never _ever_ overflow 'int' in a constant,
> without specifying the exact type you want. That way you avoid all the
> subtle cases.

That's easier to understand.
