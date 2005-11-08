From: Christoph Hellwig <hch@lst.de>
Date: Tue, 08 Nov 2005 20:55:33 +0000
Subject: Re: [PATCH] display7seg: implement ->unlocked_ioctl and ->compat_ioctl
Message-Id: <20051108205533.GA25905@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20051107194232.GD32019@lst.de>
In-Reply-To: <20051107194232.GD32019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Nov 08, 2005 at 12:48:57PM -0800, Eric Brower wrote:
> Are we intentionally locking the kernel twice in the ioctl handler?

No.  Otoh the BKL is recursive so it doesn't matter.

> I'd suggest we do away with the ioctl lock_kernel() altogether here--
> unless the interrupt handler becomes reentrant we are not going to
> experience concurrency issues.

Yes, that sounds like a good plan.  I can't test the driver so I
wouldn't want to do it myself.

