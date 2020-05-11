From: Joe Perches <joe@perches.com>
Date: Mon, 11 May 2020 01:32:07 +0000
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
Message-Id: <8bf0f4bc3ff924143fe1a90d112c73047de0288d.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
         <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
         <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
In-Reply-To: <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: chenzhou <chenzhou10@huawei.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 09:24 +0800, chenzhou wrote:
> Sorry, i made a mistake, should be scnprintf().

No worries.

But why do you think this is useful?
Is it likely that either snprint length will exceed PAGE_SIZE?

> 
> On 2020/5/9 19:40, Joe Perches wrote:
> > On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
> > > snprintf() returns the number of bytes that would be written,
> > > which may be greater than the the actual length to be written.
> > []
> > > Chen Zhou (2):
> > >   sparc: use snprintf() in show_pciobppath_attr() in pci.c
> > >   sparc: use snprintf() in show_pciobppath_attr() in vio.c
> > Your subjects are a bit off: snprintf vs scnprintf
> > 
> > 
> > 
> > 
> 
> 
