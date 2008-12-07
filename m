From: David Miller <davem@davemloft.net>
Date: Sun, 07 Dec 2008 08:04:10 +0000
Subject: Re: [RFC PATCH] sparc: expand cpu table
Message-Id: <20081207.000410.81311927.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206205710.GA27536@uranus.ravnborg.org>
In-Reply-To: <20081206205710.GA27536@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 6 Dec 2008 21:57:10 +0100

> Prepare cputable to include sparc64 versions
> Declare it __initconst so it can be dropped after init
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

This looks good to me.

Just to clarify, this only makes the "table" itself
'init' not the actual strings the table refers to, right?

We can't release the strings because those are accessed
via /proc/cpuinfo et al.
