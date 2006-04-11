From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Apr 2006 06:03:22 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <20060410.230322.05329365.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Mon, 10 Apr 2006 20:24:40 -0700

>     I think the problem may be with the way fdisk is creating the 
> labels. Here is how they are doing it.

It's how they are "doing it" eh?

You've shown a data structure, data structures don't "do" anything,
whereas code executes and "does" things.

What about this data structure layout makes you think fdisk is
doing something wrong?

Please don't just dump information into the discussion without saying
what you think it's showing us.  What's wrong with it?

It's declared almost identically to the kernel one, the only
difference is that the kernel copy uses the big-endian tagged types
which are not available in userspace.  None of the type sizes or
required alignment is different, the structure layout should be
identical.

Furthermore, you stated that if the only thing you change in the
test is to use a kernel compiled with gcc-4.1, that fails.  How
can fdisk have any influence upon such a case?

People really need to learn how to report bugs properly and help the
process move forward, instead of backward.  Many people who report
sparc64 bugs do things which waste time and hinder the debugging
process.  Cheers to the folks who do not fall into this category, but
sadly most do and since I'm the only person working on the sparc64
kernel actively this is incredibly frustrating.
