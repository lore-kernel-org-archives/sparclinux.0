From: David Miller <davem@davemloft.net>
Date: Mon, 29 Jan 2018 19:29:01 +0000
Subject: Re: [PATCH -next] oradax: Fix return value check in dax_attach()
Message-Id: <20180129.142901.541155013730243664.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1517040659-37838-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1517040659-37838-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sat, 27 Jan 2018 08:10:59 +0000

> In case of error, the function class_create() returns ERR_PTR() and
> never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().
> 
> Fixes: dd0273284c74 ("sparc64: Oracle DAX driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thank you.
