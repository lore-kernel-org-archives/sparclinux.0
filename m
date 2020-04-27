From: David Miller <davem@davemloft.net>
Date: Mon, 27 Apr 2020 16:14:38 +0000
Subject: Re: [PATCH -next] sparc64: vcc: Fix error return code in vcc_probe()
Message-Id: <20200427.091438.1070286832296952889.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200427122415.47416-1-weiyongjun1@huawei.com>
In-Reply-To: <20200427122415.47416-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2020 14:27:47 +0200

> On Mon, Apr 27, 2020 at 12:24:15PM +0000, Wei Yongjun wrote:
>> Fix to return negative error code -ENOMEM from the error handling
>> case instead of 0, as done elsewhere in this function.
>> 
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/tty/vcc.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Why is sparc64 in your subject line?

It's a sparc64 hypervisor console driver.
