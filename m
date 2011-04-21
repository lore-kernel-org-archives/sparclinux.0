From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 22:38:26 +0000
Subject: Re: [PATCH 1/3] sparc32: fix section mismatch warnings in apc, pmc
Message-Id: <20110421.153826.104050788.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1303330141-31123-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1303330141-31123-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 22:08:59 +0200

> In all cases there were a struct of_device_id variable defined __initdata.
> But it was referenced from struct platform_driver.of_match_table
> which is not guaranteed to be used during init only.
> 
> So drop the __initdata annotation.
> 
> This fixes following warnings:
...
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Sam, I'm going to apply this to sparc-2.6 because these are actually
real bugs.

If we initdata the OF driver match information, the generic device
driver layer could reference this freed memory.

Thanks!

