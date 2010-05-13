From: David Miller <davem@davemloft.net>
Date: Thu, 13 May 2010 21:11:49 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <20100513.141149.212670650.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Mach <alexvm12e@mail.ru>
Date: Thu, 13 May 2010 17:56:01 +0400

> The problem happens when ethoc_read() call ioread32() with phys addr
> 0xFFF0C2C100.

That means there is nothing responding at that physical address.

