From: David Miller <davem@davemloft.net>
Date: Thu, 29 Dec 2011 23:14:31 +0000
Subject: Re: [PATCH 2/2] sparc32: fix PAGE_SIZE definition
Message-Id: <20111229.181431.1400937684235301156.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111229141612.GB3146@merkur.ravnborg.org>
In-Reply-To: <20111229141612.GB3146@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 15:16:12 +0100

>>From 1076481b278bd14617a544cc20520cfd73f9b12c Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 29 Dec 2011 15:04:38 +0100
> Subject: [PATCH 2/2] sparc32: fix PAGE_SIZE definition
> 
> Use _AC() in definition of PAGE_SIZE so the same definition
> can be used in C and assembler.
> Also use PAGE_SIZE in definition of THREAD_SIZE.
> 
> This commit kill the following comment:
> 
>     "I have my suspicions... -DaveM"
> 
> I did not find any clue what this referred to anyway.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.

That comment was written by some newbie, ignore him :-)
