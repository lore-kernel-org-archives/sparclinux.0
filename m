From: David Miller <davem@davemloft.net>
Date: Wed, 13 May 2020 22:36:20 +0000
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
Message-Id: <20200513.153620.318526782161817591.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
In-Reply-To: <20200509091849.116954-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: chenzhou10@huawei.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>
Date: Sat, 9 May 2020 17:18:47 +0800

> snprintf() returns the number of bytes that would be written,
> which may be greater than the the actual length to be written.
> 	    
> show() methods should return the number of bytes printed into the
> buffer. This is the return value of scnprintf().

Series applied with Subject lines corrected.
