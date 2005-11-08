From: Eric Brower <ebrower@gmail.com>
Date: Tue, 08 Nov 2005 20:58:16 +0000
Subject: Re: [PATCH] cpwatchdog: implement ->compat_ioctl
Message-Id: <ec7cefb0511081258v19e41815w720a18c4d55cde43@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194320.GE32019@lst.de>
In-Reply-To: <20051107194320.GE32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I noticed the envctrl.c patch bounds the assignment of .compat_ioctl
by #ifdef CONFIG_COMPAT but the patch to cpwatchdog.c does not. 
What's the currently preferred convention?  I'd assume it is
unnecessary for in-kernel drivers, but I'd appreciate your take.

Thanks,
E

On 11/7/05, David S. Miller <davem@davemloft.net> wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 7 Nov 2005 20:43:20 +0100
>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Applied, thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
E
