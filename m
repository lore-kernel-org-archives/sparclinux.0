From: David Miller <davem@davemloft.net>
Date: Wed, 28 Jun 2006 18:32:54 +0000
Subject: Re: [PATCH] sparc: remove sunzilog_console_init
Message-Id: <20060628.113254.78711411.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060628141601.GA31139@palantir8>
In-Reply-To: <20060628141601.GA31139@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 28 Jun 2006 15:16:01 +0100

> This patch against 2.6.17 resolves the following build warning:
>   CC      drivers/serial/sunzilog.o
> drivers/serial/sunzilog.c:1390: warning: `sunzilog_console_init' defined but not used
> 
> It was tested on a SS20 with the console on a sunzilog.

I see that warning too, but there is no other code around to
register the console :-)

I did some transformations over the last year that somehow
made this function no longer invoked, when it should be,
and I need to figure that out and fix the problem properly.
