From: David Miller <davem@davemloft.net>
Date: Thu, 10 Aug 2017 05:21:24 +0000
Subject: Re: [PATCH V2] vDSO for SPARC
Message-Id: <20170809.222124.235190705496955434.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1499268125-877874-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1499268125-877874-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I want to apply this patch, but you will first need to respin it
against sparc-next, f.e. sparc64_init_timers() doesn't exist in any of
my trees any more but this patch tries to make changes there.

Thank you.
