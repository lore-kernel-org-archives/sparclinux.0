From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jan 2009 00:59:35 +0000
Subject: Re: [PATCH v2 4/5] sparc: Kill exports of prom internal functions
Message-Id: <20090108.165935.128598881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1F8.20900@gmail.com>
In-Reply-To: <4965F1F8.20900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 08 Jan 2009 23:30:48 +1100

> sparc: Kill exports of prom internal functions
> 
> __prom_getchild() and __prom_getsibling() are not used anywhere, so
> don't export them.
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Applied.
