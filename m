From: David Miller <davem@davemloft.net>
Date: Mon, 21 Dec 2009 20:14:11 +0000
Subject: Re: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <20091221.121411.193695259.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Dec 2009 20:59:21 +0100

> As the comment says:
> "Don't use BUG() or BUG_ON() unless there's really no way out;"
> 
> I would have expected to see something like this:
> #define BUG() do {} while(1)

Maybe we can use "unreachable()" here.
