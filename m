From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2007 08:08:15 +0000
Subject: Re: [PATCH] sun_esp.c build for sparc32 UP
Message-Id: <20070529.010815.21922742.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070528234304.GA24466@palantir8>
In-Reply-To: <20070528234304.GA24466@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 29 May 2007 00:43:04 +0100

> These are due to udelay(). The code includes asm/delay.h (indirectly), but
> that is not enough to make it work.

Indeed, my initial suspicion was right, I have fixed this already
in my sparc-2.6 GIT tree since late last week.

I've been meaning to push this fix to Linus along with the rest of
my sparc-2.6 GIT tree but it's been waiting on a sparc64 bug fix
that haven't been able to complete due to a binutils bug which
I only figured out late last night.

So please be patient or use my sparc-2.6 GIT tree :-)
