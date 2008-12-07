From: David Miller <davem@davemloft.net>
Date: Sun, 07 Dec 2008 08:02:18 +0000
Subject: Re: [PATCH] sparc: fix sparse warnings in cpu_*.c
Message-Id: <20081207.000218.81422171.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206201155.GA24227@uranus.ravnborg.org>
In-Reply-To: <20081206201155.GA24227@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 6 Dec 2008 21:11:55 +0100

> o declare variables from cpu_*.c
> o declare function from cpu_32.c
> 
> To do this introduce a new header "kernel.h" which is local to kernel/
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> Just a quick sample where kernel.h is introduced.
> With this I could get rid of a few sparse warnings and
> the code is better.

Looks good, applied.
