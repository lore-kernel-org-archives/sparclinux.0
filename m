From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 17:48:23 +0000
Subject: Re: [PATCH] sparc32: cleanup mm/fault_32.c
Message-Id: <20120515.134823.2116571767552382436.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515170434.GA13518@merkur.ravnborg.org>
In-Reply-To: <20120515170434.GA13518@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 19:04:34 +0200

>>From 08f1ed3b3fdf4d25068c457fcf249413f2235f97 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 15 May 2012 19:02:08 +0200
> Subject: [PATCH] sparc32: cleanup mm/fault_32.c
> 
> - remove unused variables
> - fix coding style issues that hurts my eyes
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.

> Noticed a few unused variables and then an "if(" and then...
> I actually ran checkpatch on the file too - but
> ignored most of the complaints.

You'll have to excuse me, as I wrote most of this code before I
actually knew how to program :-)
