From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2013 09:13:55 +0000
Subject: Re: [PATCH] sparc: kernel: using strlcpy() instead of strcpy()
Message-Id: <20130619.021355.817047518251404651.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <51B44396.9030209@huawei.com>
In-Reply-To: <51B44396.9030209@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Zhao Hongjiang <zhaohongjiang@huawei.com>
Date: Sun, 9 Jun 2013 16:57:58 +0800

> 'boot_command_line' and 'full_boot_str' has a fix length, 'cmdline_p' and
> 'boot_command' maybe larger than them. So use strlcpy() instead of strcpy() 
> to avoid memory overflow.
> 
> Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>

Applied.
