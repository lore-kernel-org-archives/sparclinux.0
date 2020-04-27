From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2020 17:28:56 +0000
Subject: Re: [PATCH -next] sparc64: vcc: Fix error return code in vcc_probe()
Message-Id: <20200427172856.GA3936841@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200427122415.47416-1-weiyongjun1@huawei.com>
In-Reply-To: <20200427122415.47416-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Mon, Apr 27, 2020 at 09:14:38AM -0700, David Miller wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Mon, 27 Apr 2020 14:27:47 +0200
> 
> > On Mon, Apr 27, 2020 at 12:24:15PM +0000, Wei Yongjun wrote:
> >> Fix to return negative error code -ENOMEM from the error handling
> >> case instead of 0, as done elsewhere in this function.
> >> 
> >> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> >> ---
> >>  drivers/tty/vcc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> > 
> > Why is sparc64 in your subject line?
> 
> It's a sparc64 hypervisor console driver.

Ah, that wasn't very obvious, sorry about that.

greg k-h
