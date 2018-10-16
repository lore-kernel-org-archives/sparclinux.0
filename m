From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 16 Oct 2018 16:55:14 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20181016165514.GE9547@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181015.193945.304905055642913000.davem@davemloft.net>
In-Reply-To: <20181015.193945.304905055642913000.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:39:45PM -0700, David Miller wrote:
> 
> 1) Revert the %pOF change, it causes regressions.
> 
> 2) Wire up io_pgetevents().
> 
> 3) Fix perf events on single-PCR sparc64 cpus.
> 
> 4) Do proper perf event throttling like arm and x86.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit 0854ba5ff5c938307cd783e996b62c83f1ce923b:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2018-10-08 16:25:01 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

Now merged, thanks.

greg k-h
