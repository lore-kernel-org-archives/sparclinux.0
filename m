From: "David S. Miller" <davem@redhat.com>
Date: Sat, 07 Feb 2004 03:29:14 +0000
Subject: Re: AIO syscall patch, and problem
Message-Id: <20040206192914.15bb375b.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1075876893.5035.60.camel@ori.thedillows.org>
In-Reply-To: <1075876893.5035.60.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04 Feb 2004 02:02:30 -0500
David Dillow <dave@thedillows.org> wrote:

> The attached patch fixes a mis-numbering of the AIO syscalls under sparc
> and sparc64. I would have simply moved them all down, but then
> io_getevents would be at 272, and the big WARNING comment says we cannot
> use numbers larger than 271, so there you are. I used the oldstat
> syscall, since it was commented out.

There must be more to your patch right?  Just changing the numbers
in the unistd.h files does not fix up the syscall table itself too.

I'll look into this and I may fix it differently.

> The problem is __copy_to_user() is being called with a size of 512, but
> is returning 576. size then underflows in the conditional, and
> aio_complete() eventually gets called with this as its return code,
> hence, -EHOSTDOWN.

I'll look into this too, that's a bad bug.
