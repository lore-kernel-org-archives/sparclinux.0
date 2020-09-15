From: David Miller <davem@davemloft.net>
Date: Tue, 15 Sep 2020 00:05:38 +0000
Subject: Re: [PATCH] sbus: char: Remove meaningless jump label out_free
Message-Id: <20200914.170538.2141404011708907680.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200911071341.101397-1-jingxiangfeng@huawei.com>
In-Reply-To: <20200911071341.101397-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jingxiangfeng@huawei.com
Cc: dan.j.williams@intel.com, dvhart@infradead.org, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, dsterba@suse.com, arnd@arndb.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jing Xiangfeng <jingxiangfeng@huawei.com>
Date: Fri, 11 Sep 2020 15:13:41 +0800

> After commit 57a4a3d7f756 ("display7seg: Introduce the use of the managed
> version of kzalloc"), The out_free jump label has nothing to do but goto
> out. So remove it.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Applied, thank you.
