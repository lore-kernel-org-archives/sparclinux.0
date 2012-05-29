From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2012 01:49:18 +0000
Subject: Re: [PATCH] sparc32,leon: fix leon bootup
Message-Id: <20120528.214918.503189996170928146.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120528205125.GA20640@merkur.ravnborg.org>
In-Reply-To: <20120528205125.GA20640@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 28 May 2012 22:51:25 +0200

>>From 1ea4052166ab9c09a4a591bb59dafbcb188d1add Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 28 May 2012 22:44:44 +0200
> Subject: [PATCH] sparc32,leon: fix leon bootup
> 
> head_32.S failed to set cputypval for leon, causing boot to fail.
> The boot failed because we failed to recognize this was a LEON
> cpu so we did not preoperly run-time patch the the kernel.
> This resulted in an early crash.
> 
> Refactor head_32.S such that we always determine the cpu
> model based on the getprops("compatible") call.
> this resulted in cleaner code.
> 
> We continue to recognize the LEON cpu
> using PSR in the very early boot phase.
> 
> Reported-by: Daniel Hellstrom <daniel@gaisler.com>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I'll apply this once it gets a LEON test.
