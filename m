From: David Miller <davem@davemloft.net>
Date: Thu, 18 Aug 2011 08:59:33 +0000
Subject: Re: [PATCH] sparc: fix array bounds error setting up PCIC NMI trap
Message-Id: <20110818.015933.467598459203363746.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1313655297-20075-1-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1313655297-20075-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ian Campbell <ian.campbell@citrix.com>
Date: Thu, 18 Aug 2011 09:14:57 +0100

>>From a sparc64 defconfig:
>   CC      arch/sparc/kernel/pcic.o

A sparc64 defconfig?  This is code only built for 32-bit sparc :-)
