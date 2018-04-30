From: David Miller <davem@davemloft.net>
Date: Mon, 30 Apr 2018 20:10:00 +0000
Subject: Re: [PATCH] sparc: vio: use put_device() instead of kfree()
Message-Id: <20180430.161000.699679324055043425.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arvind.yadav.cs@gmail.com
Cc: shannon.nelson@oracle.com, jag.raman@oracle.com, liam.merwick@oracle.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 25 Apr 2018 20:26:14 +0530

> Never directly free @dev after calling device_register(), even
> if it returned an error. Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied and queued up for -stable, thanks.
