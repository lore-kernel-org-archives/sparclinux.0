From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 23:07:56 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20130930.190756.557675851880870874.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Mon, 30 Sep 2013 13:14:01 -0700

> And I think we need to increase NR_CPUS.

Just set the config option to the appropriate value when you build, I
set it to 128 for my T4-2.
