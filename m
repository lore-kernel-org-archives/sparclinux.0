From: David Miller <davem@davemloft.net>
Date: Wed, 18 Sep 2013 03:59:28 +0000
Subject: Re: [PATCH 2/2] sparc64: Implement HAVE_CONTEXT_TRACKING
Message-Id: <20130917.235928.1236076354689883403.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <149311379160131@web12j.yandex.ru>
In-Reply-To: <149311379160131@web12j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 14 Sep 2013 16:02:11 +0400

> Mark the places when the system are in user or are in kernel.
> This is used to make full dynticks system (tickless) --
> CONFIG_NO_HZ_FULL dependence.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Thanks for doing this work.

I started reviewing these two patches and familiarizing myself
with what the context tracking infrastructure wants.
