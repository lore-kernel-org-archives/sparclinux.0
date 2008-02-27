From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 27 Feb 2008 08:02:22 +0000
Subject: Re: [BUG] 2.6.25-rc3 hangs in early boot on Sun Ultra5
Message-Id: <alpine.LFD.1.00.0802270858450.7583@apollo.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <18371.10207.58819.188510@alkaid.it.uu.se> <18371.54294.748777.976300@harpo.it.uu.se> <20080226.164900.193701385.davem@davemloft.net> <20080226.170613.107688605.davem@davemloft.net>
In-Reply-To: <20080226.170613.107688605.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 26 Feb 2008, David Miller wrote:
> What the FUTEX checking code is doing now is doing a "user" access
> with set_fs(KERNEL_DS) since it runs from the kernel bootup early init
> sequence.  And this is illegal according to the existing checks.
> 
> When we do set_fs(KERNEL_DS) then pass a "user" pointer down
> into a system call or something like that, we give it a pointer
> that "cannot fault".  So if we get into the fault handling
> path here for a case like that we really do want to scream and
> print out an OOPS message in my opinion.

So it would be correct to set_fs(USER_DS) then do the check and switch
back to KERNEL_DS ?
 
> I realize that not many platforms other than sparc64 can check
> for things this precisely, but it's something to consider.

Hmm, I missed that.
 
> Did this FUTEX change go into -stable too?

It's queued, AFAIK

Thanks,
	tglx
