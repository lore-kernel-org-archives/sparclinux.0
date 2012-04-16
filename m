From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2012 21:39:28 +0000
Subject: Re: [PATCH] sparc32: fix build of pcic
Message-Id: <20120416.173928.2275734421356893851.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120416195702.GA19692@merkur.ravnborg.org>
In-Reply-To: <20120416195702.GA19692@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Apr 2012 21:57:02 +0200

>>From 2f007277975e8bce2b9142b28b609d7a4e9a631e Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 16 Apr 2012 21:50:49 +0200
> Subject: [PATCH] sparc32: fix build of pcic
> 
> Left-overs for an earlier iteration of the generic clock events patch removed.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Kirill Tkhai <tkhai@yandex.ru>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks.

> I assume you will not fold the two patches as sparc-next is out in the public.

That's correct.
