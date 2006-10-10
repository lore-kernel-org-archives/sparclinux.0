From: David Miller <davem@davemloft.net>
Date: Tue, 10 Oct 2006 01:10:34 +0000
Subject: Re: [PATCH] sparc32: Fix prom.c build warning
Message-Id: <20061009.181034.07641360.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061009164820.GA26520@palantir8>
In-Reply-To: <20061009164820.GA26520@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 9 Oct 2006 17:48:20 +0100

> Fix these 2.6.19-rc1 build warnings:
> 
>   CC      arch/sparc/kernel/prom.o
> arch/sparc/kernel/prom.c: In function `of_set_property':
> arch/sparc/kernel/prom.c:246: warning: passing arg 2 of `prom_setprop' discards qualifiers from pointer target type
> arch/sparc/kernel/prom.c: In function `build_one_prop':
> arch/sparc/kernel/prom.c:446: warning: unused variable `len'
> arch/sparc/kernel/prom.c:480: warning: ignoring return value of `prom_getproperty', declared with attribute warn_unused_result
> 
> Martin
> 
> 	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Applied, thanks Martin.
