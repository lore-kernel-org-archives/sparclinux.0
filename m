From: chenzhou <chenzhou10@huawei.com>
Date: Mon, 11 May 2020 01:24:21 +0000
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
Message-Id: <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
 <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
In-Reply-To: <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Sorry, i made a mistake, should be scnprintf().


On 2020/5/9 19:40, Joe Perches wrote:
> On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
>> snprintf() returns the number of bytes that would be written,
>> which may be greater than the the actual length to be written.
> []
>> Chen Zhou (2):
>>   sparc: use snprintf() in show_pciobppath_attr() in pci.c
>>   sparc: use snprintf() in show_pciobppath_attr() in vio.c
> Your subjects are a bit off: snprintf vs scnprintf
>
>
>
>
