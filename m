From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 02 Oct 2005 01:26:20 +0000
Subject: Re: [2.6 patch] sparc: "extern inline" -> "static inline"
Message-Id: <20051001.182620.32883151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050902202444.GS3657@stusta.de>
	<20050902.132754.118393946.davem@davemloft.net>
	<20051001230628.GF4212@stusta.de>
In-Reply-To: <20051001230628.GF4212@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@stusta.de
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 2 Oct 2005 01:06:28 +0200

> I just tried 2.6.14-rc3 and 2.6.14-rc2-mm2, and it applied against both.

'patch' and friends are much more lenient about white space
and other types of "fuzz" than the git patch application code
is.  So that can often be the reason.

But this version applies properly, thanks a lot Adrian.
