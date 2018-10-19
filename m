From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 19 Oct 2018 07:16:00 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20181019071600.GC28551@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181018.163323.331525365210775149.davem@davemloft.net>
In-Reply-To: <20181018.163323.331525365210775149.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 04:33:23PM -0700, David Miller wrote:
> 
> The main bit here is fixing how fallback system calls are handled in
> the sparc vDSO.
> 
> Unfortunately, I fat fingered the commit and some perf debugging hacks
> slipped into the vDSO fix, which I revert in the very next commit.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit c343db455eb3105f11bb5ac290d77ab2006b0209:
> 
>   Merge branch 'parisc-4.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2018-10-17 14:01:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

Now merged, thanks.

greg k-h
