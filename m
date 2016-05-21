From: David Miller <davem@davemloft.net>
Date: Sat, 21 May 2016 01:34:36 +0000
Subject: Re: [PATCH] openprom: fix uninitialized warnings
Message-Id: <20160520.213436.1367882738059675383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 24 Apr 2016 15:34:27 +0200

> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 24 Apr 2016 15:24:33 +0200
> Subject: [PATCH 1/1] openprom: fix warning
> 
> Fix following warnings:
> openprom.c:510:2: warning: 'tmp' may be used uninitialized in this function [-Wmaybe-uninitialized]
> openprom.c:503:3: warning: 'str' may be used uninitialized in this function [-Wmaybe-uninitialized]
> openprom.c:459:8: warning: 'str' may be used uninitialized in this function [-Wmaybe-uninitialized]
> openprom.c:422:7: warning: 'str' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Fixed by introducing PTR_ERR etc.
> This simplified the code as a nice side effect.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
