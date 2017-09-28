From: David Miller <davem@davemloft.net>
Date: Thu, 28 Sep 2017 04:52:16 +0000
Subject: Re: [PATCH] sparc: time: Remove unneeded linux/miscdevice.h include
Message-Id: <20170927.215216.13543607975061749.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170918175821.20026-1-clabbe.montjoie@gmail.com>
In-Reply-To: <20170918175821.20026-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clabbe.montjoie@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 18 Sep 2017 19:58:21 +0200

> arch/sparc/kernel/time_64.c does not contain any miscdevice so the
> inclusion of linux/miscdevice.h is unnecessary.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Applied.
