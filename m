From: David Miller <davem@davemloft.net>
Date: Sat, 26 Feb 2011 07:01:27 +0000
Subject: Re: [PATCH 3/5] sparc32: introduce build_device_irq
Message-Id: <20110225.230127.71111578.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1298234400-22378-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298234400-22378-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Feb 2011 21:39:58 +0100

> build_device_irq() is used to encapsulate the plaform
> specific details when we build an irq.
> For now the default is a simple 1:1 but sun4d differs.
> This patch refactors functionality - but does not change
> the existing functionality.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
