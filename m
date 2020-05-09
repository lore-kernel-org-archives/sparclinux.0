From: Joe Perches <joe@perches.com>
Date: Sat, 09 May 2020 11:40:10 +0000
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
Message-Id: <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
In-Reply-To: <20200509091849.116954-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Zhou <chenzhou10@huawei.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
> snprintf() returns the number of bytes that would be written,
> which may be greater than the the actual length to be written.
[]
> Chen Zhou (2):
>   sparc: use snprintf() in show_pciobppath_attr() in pci.c
>   sparc: use snprintf() in show_pciobppath_attr() in vio.c

Your subjects are a bit off: snprintf vs scnprintf
