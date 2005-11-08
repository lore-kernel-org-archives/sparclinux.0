From: Eric Brower <ebrower@gmail.com>
Date: Tue, 08 Nov 2005 20:48:57 +0000
Subject: Re: [PATCH] display7seg: implement ->unlocked_ioctl and ->compat_ioctl
Message-Id: <ec7cefb0511081248l618b5abelbe3ac6e664d65a53@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194232.GD32019@lst.de>
In-Reply-To: <20051107194232.GD32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Are we intentionally locking the kernel twice in the ioctl handler?

I'd suggest we do away with the ioctl lock_kernel() altogether here--
unless the interrupt handler becomes reentrant we are not going to
experience concurrency issues.

E

On 11/7/05, David S. Miller <davem@davemloft.net> wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 7 Nov 2005 20:42:32 +0100
>
> > all ioctls are 32bit compat clean, so the driver can use ->compat_ioctl
> > and ->unlocked_ioctl easily.
> >
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
