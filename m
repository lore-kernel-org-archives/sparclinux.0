From: David Miller <davem@davemloft.net>
Date: Thu, 04 Dec 2008 21:28:34 +0000
Subject: Re: [PATCH] sparc: unify kernel/init_task
Message-Id: <20081204.132834.182484368.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081204212543.GB28342@uranus.ravnborg.org>
In-Reply-To: <20081204212543.GB28342@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 4 Dec 2008 22:25:43 +0100

> A closer inspection revealed that these two files had identical
> functionality - but the implementation of it differed slightly.
> 
> Base it on the sparc version as it was the best.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> On purpose I did not use "-M -B" so you could see
> the content of the deleted file.
> I expect git to see that we deleted one file and moved another.

Looks good, applied.

I'll test boot this one before pushing it out to kernel.org :)
