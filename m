From: David Miller <davem@davemloft.net>
Date: Fri, 22 May 2009 00:18:05 +0000
Subject: Re: [PATCH v2] sparc64: fix and optimize irq distribution
Message-Id: <20090521.171805.08700556.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1242233551-3369-1-git-send-email-hong.pham@windriver.com>
In-Reply-To: <1242233551-3369-1-git-send-email-hong.pham@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 21 May 2009 17:14:24 -0700 (PDT)

> I'm happy to apply this patch once you change it to use the MDESC
> properly to probe the cpu hierarchy information.

BTW, you could also use the precomputed scheduler grouping
cpu masks in your distribution table building too.
