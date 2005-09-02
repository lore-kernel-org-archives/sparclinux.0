From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 02 Sep 2005 20:27:54 +0000
Subject: Re: [2.6 patch] sparc: "extern inline" -> "static inline"
Message-Id: <20050902.132754.118393946.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050902202444.GS3657@stusta.de>
In-Reply-To: <20050902202444.GS3657@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@stusta.de
Cc: wli@holomorphy.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 2 Sep 2005 22:24:44 +0200

> "extern inline" doesn't make much sense.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Patch does not apply to Linus's current tree, every change
in include/asm-sparc/spinlock.h was rejected.
