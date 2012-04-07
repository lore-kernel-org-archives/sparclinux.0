From: David Miller <davem@davemloft.net>
Date: Sat, 07 Apr 2012 09:22:49 +0000
Subject: Re: sparc32 paging fault which I cannot explain
Message-Id: <20120407.052249.1291968424690914177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120406152619.GA17138@merkur.ravnborg.org>
In-Reply-To: <20120406152619.GA17138@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 6 Apr 2012 22:13:55 +0200

> I found no evidence that 0xa00000 will work in general.
> So testing is required here :-(

Actually what happens is we copy one PGD from wherever the
firmware mapped us to KERNBASE.

0xa00000 is 10MB and at least on sun4m pretty reliable.
