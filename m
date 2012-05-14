From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 21:22:17 +0000
Subject: Re: [PATCH 1/2] sparc32: remove remaining users of btfixup
Message-Id: <20120514.172217.1420795628496946887.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120514160122.GA11195@merkur.ravnborg.org>
In-Reply-To: <20120514160122.GA11195@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 18:01:22 +0200

>>From 5cc7ae31c647d27cf03074f980a94f76c0b8798a Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 14 May 2012 17:30:35 +0200
> Subject: [PATCH 1/2] sparc32: remove remaining users of btfixup
> 
> Use sparc_config to hold the last two function pointers.
> There was no pint generating dedicated _ops structures onyl for these.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
