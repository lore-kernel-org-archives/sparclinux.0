From: David Miller <davem@davemloft.net>
Date: Fri, 27 Dec 2013 17:43:09 +0000
Subject: Re: [PATCH 05/38] sparc: kernel: add missing put_device call
Message-Id: <20131227.124309.1704278577980085243.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
	<1387465429-3568-6-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-6-git-send-email-levex@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: levex@linux.com
Cc: linux-kernel@vger.kernel.org, federico.vaga@gmail.com, sparclinux@vger.kernel.org

From: Levente Kurusa <levex@linux.com>
Date: Thu, 19 Dec 2013 16:03:16 +0100

> This is required so that we give up the last reference to the device.
> The kfree() has been removed because put_device will set the underlying kref's
> reference count to zero and hence vio_dev_release will get called resulting in
> kfreeing the structure.
> 
> Signed-off-by: Levente Kurusa <levex@linux.com>

There is no reference held to vdev->dev at this point, that's why
we should directly kfree() it and put_device() is not appropriate.

Pretty much all of your patches have this problem.
