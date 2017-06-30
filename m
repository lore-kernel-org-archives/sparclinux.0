From: David Miller <davem@davemloft.net>
Date: Fri, 30 Jun 2017 00:36:33 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <20170629.173633.980794918414808354.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 23:09:54 +0100

> This definitely isn't the case with the blit routines in
> drivers/video/fbdev/core/sysimgblt.c as they reference the address
> directly via a pointer so could this be the bug?

That would be a bug.
