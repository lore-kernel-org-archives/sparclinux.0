From: David Miller <davem@davemloft.net>
Date: Sun, 25 Jun 2017 20:39:24 +0000
Subject: Re: [PATCH] sparc: kernel: apc: make of_device_ids const
Message-Id: <20170625.163924.2294228535964383068.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <6d8baf5133e6aec69f472850dc54779ceba0c774.1498209603.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <6d8baf5133e6aec69f472850dc54779ceba0c774.1498209603.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arvind.yadav.cs@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Fri, 23 Jun 2017 14:51:35 +0530

> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied, thank you.
