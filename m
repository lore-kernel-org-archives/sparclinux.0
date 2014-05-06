From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 17:13:54 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20140506.131354.1811745259385565455.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.113031.1577209312429629073.davem@davemloft.net>
	<20140506162946.GA28261@redhat.com>
In-Reply-To: <20140506162946.GA28261@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davej@redhat.com
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Tue, 6 May 2014 12:29:46 -0400

> It seems like forever you go you sent me patches to trinity to make it
> work on sparc. I'm curious if you've tried running it again more
> recently ?   Given the work I've done it to do more creative things with
> VM related syscalls, I wouldn't be surprised if it also found some sparc
> specific bugs in thp.
> 
> It should now also scale up to run a lot more child processes than the older
> version, with the -c option, which could be interesting on some of the
> bigger sparc machines.
> 
> (It's entirely possible I've broken the compile on non-x86 in
>  current git, but it shouldn't be much work to fix up).
> 
> git://github.com/kernelslacker/trinity is where it lives now.

Thanks Dave, I'll take a look and get back to you.
