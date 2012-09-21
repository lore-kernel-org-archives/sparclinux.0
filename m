From: David Miller <davem@davemloft.net>
Date: Fri, 21 Sep 2012 19:16:45 +0000
Subject: Re: [PATCH] sparc: fix the return value of module_alloc()
Message-Id: <20120921.151645.113767206941076122.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPgLHd-ND_itgeVLvvqFZEU1peMuCk=dAfFhkH68KFV7biHhzA@mail.gmail.com>
In-Reply-To: <CAPgLHd-ND_itgeVLvvqFZEU1peMuCk=dAfFhkH68KFV7biHhzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Fri, 21 Sep 2012 12:57:51 +0800

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, function module_alloc() in other platform never
> returns ERR_PTR(), and all of the user only check for NULL, so
> we'd better return NULL instead of ERR_PTR().
> 
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks.
