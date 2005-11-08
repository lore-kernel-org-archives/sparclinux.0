From: Eric Brower <ebrower@gmail.com>
Date: Tue, 08 Nov 2005 20:53:06 +0000
Subject: Re: [PATCH] cpwatchdog: implement ->compat_ioctl
Message-Id: <ec7cefb0511081253y13f81930vef2c3ffef055d0ba@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194320.GE32019@lst.de>
In-Reply-To: <20051107194320.GE32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We seem to be calling lock_kernel() twice here too-- am I
misunderstanding some nuance of the BKL?

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
