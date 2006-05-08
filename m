From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 08 May 2006 06:03:32 +0000
Subject: Re: [PATCH] sparc: fix warning on prom_getproperty in openprom.c
Message-Id: <20060507.230332.16139972.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060507152450.GA3426@palantir8>
In-Reply-To: <20060507152450.GA3426@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 7 May 2006 16:24:50 +0100

> This patch resolves the following build warnings seen in 2.6.17-rc3:
> drivers/sbus/char/openprom.c:395: warning: ignoring return value of `prom_getproperty', declared with attribute warn_unused_result
> 
> Please apply.
> Martin
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

The intention is correct but if we get an error from
prom_getproperty() then -EFAULT is not likely the appropiate thing to
return.  Perhaps -EINVAL or something like that.
