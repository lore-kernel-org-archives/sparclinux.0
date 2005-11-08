From: Eric Brower <ebrower@gmail.com>
Date: Tue, 08 Nov 2005 21:19:21 +0000
Subject: Re: [PATCH] display7seg: implement ->unlocked_ioctl and ->compat_ioctl
Message-Id: <ec7cefb0511081319k45a8d032ydf18c13e24c0f693@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194232.GD32019@lst.de>
In-Reply-To: <20051107194232.GD32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/8/05, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Nov 08, 2005 at 12:48:57PM -0800, Eric Brower wrote:
> > Are we intentionally locking the kernel twice in the ioctl handler?
>
> No.  Otoh the BKL is recursive so it doesn't matter.

I'm speaking specifically of the patch doing the following within the
driver's ioctl handler:

  lock_kernel()
    ... handle ioctl
  lock_kernel()

We ought to be calling unlock_kernel() at the end, correct?
--
E
