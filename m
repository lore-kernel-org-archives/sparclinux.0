From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 12 May 2006 18:37:23 +0000
Subject: Re: [PATCH] sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060512.113723.109019374.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060511180731.GB16957@palantir8>
In-Reply-To: <20060511180731.GB16957@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 12 May 2006 14:02:03 +0100

> The -fasynchronous-unwind-tables is turned on because I had
> CONFIG_UNWIND_INFO=y set in my .config.

That explains everything :-)

I'll do some test builds and add the necessary relocation
support to both sparc32 and sparc64.

Thanks a lot.
