From: David Miller <davem@davemloft.net>
Date: Thu, 11 Feb 2010 20:27:43 +0000
Subject: Re: Bug in [PATCH] sparc: Align clone and signal stacks to 16 bytes
Message-Id: <20100211.122743.20125640.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5581002110931s3923f3d1haa9d82abe2c9451@mail.gmail.com>
In-Reply-To: <f43fc5581002110931s3923f3d1haa9d82abe2c9451@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Blue Swirl <blauwirbel@gmail.com>
Date: Thu, 11 Feb 2010 19:31:47 +0200

> Hi,
> 
> I just browsed sparc-linux list and spotted this bug in the patch:
> 
>  			childstack = (struct sparc_stackf __user *)
> -				(sp & ~0x7UL);
> +				(sp & ~0x15UL);
>  			parentstack = (struct sparc_stackf __user *)
> 
> 0x15UL is wrong, it should be either 0xfUL or 15UL.

Thanks, I'll fix that.
