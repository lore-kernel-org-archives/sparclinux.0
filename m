From: David Miller <davem@davemloft.net>
Date: Sun, 05 Nov 2006 22:21:15 +0000
Subject: Re: Strange kernel messages bootinh 2.6.18.2 on an E4000
Message-Id: <20061105.142115.28789076.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
In-Reply-To: <20061105120547.GA3665@pelagius.h-e-r-e-s-y.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: andrew@walrond.org
Date: Sun, 5 Nov 2006 22:15:40 +0000

> Thanks for the info. I'll take a look at edgy and see what they have done.

The current Dapper has this stuff too.

> Is anybody else running a pure 64bit distro? I am finding two of my
> favourite tools, xemacs and gdb to be a tad flakey. Haven't done any
> serious investigating yet, or reported any bugs. Just wondered if
> anyone else has experienced this?

I've built a native gdb64 under Dapper and it works just fine.
But the normal 32-bit gdb works just fine for 32-bit applications
for me, except for threaded stuff which never worked %100 and
won't even with a 64-bit gdb.

A pure-64bit userland on sparc64 is an _incredibly_ _stupid_ idea.
The only thing you'll get is larger binaries, worse performance, and
maybe 1 or 2 tools which work a slightly better but could be easily
fixed to work properly as a 32-bit app too.
