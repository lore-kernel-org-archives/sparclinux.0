From: David Miller <davem@davemloft.net>
Date: Fri, 07 Aug 2015 22:22:56 +0000
Subject: Re: [PATCH] sparc64: use ENTRY/ENDPROC in VISsave
Message-Id: <20150807.152256.960911445777356991.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150807183412.GA12019@ravnborg.org>
In-Reply-To: <20150807183412.GA12019@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 7 Aug 2015 20:34:12 +0200

> From 7d8a508d74e6cacf0f2438286a959c3195a35a37 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 7 Aug 2015 20:26:12 +0200
> Subject: [PATCH] sparc64: use ENTRY/ENDPROC in VISsave
> 
> Commit 44922150d87cef616fd183220d43d8fde4d41390
> ("sparc64: Fix userspace FPU register corruptions") left a
> stale globl symbol which was not used.
> 
> Fix this and introduce use of ENTRY/ENDPROC
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.
