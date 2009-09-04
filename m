From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Fri, 04 Sep 2009 11:21:37 +0000
Subject: Re: 2.6.31-rc1: sparc T2: Fast Data Access MMU Miss
Message-Id: <a4423d670909040421q29222f52i42095959ae95305c@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090904.030857.98883610.davem@davemloft.net>
In-Reply-To: <20090904.030857.98883610.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2009/9/4 David Miller <davem@davemloft.net>:
>
> The problem is that is a missing "notrace" annotation.
>
> It triggers with your config because some functions don't get
> inlined by the compiler which normally would be (which is why
> I've never seen this before).
>
> Please try this patch, thanks!
>
> sparc64: Fix bootup with mcount in some configs.

Sorry, I can't test. I don't have an access to this hardware anymore.
