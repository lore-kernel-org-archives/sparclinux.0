From: David Miller <davem@davemloft.net>
Date: Fri, 28 Sep 2012 02:15:54 +0000
Subject: Re: [PATCH 2/2] do_rt_sigreturn provide the target sp
Message-Id: <20120927.221554.1110783513905991926.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1348760205-26101-3-git-send-email-bpicco@meloft.net>
In-Reply-To: <1348760205-26101-3-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Thu, 27 Sep 2012 11:36:45 -0400

> do_sigaltstack expects the stack we are returning to. An issue will manifest
> with an alternate stack. That is, a sigaltstack followed by a sigaction
> (aka. rt_sigaction) with SA_ONSTACK for flags will sigsegv. do_sigaltstack
> returns -EPERM having found on_sig_stack to be true and a sigsegv results.
> 
> Let's teach do_rt_sigreturn to provide do_sigaltstack with our target stack.

"sf" is our target stack frame in the stack frame pointed to by
UREG_FP.

You really haven't described the real reason why this doesn't work
as-is, and therefore your commit message is inadequate and made me do
a lot of work I shouldn't have to do.

Your commit message implies that we are not passing in something
related to the stack frame, but we actually are.

And if this location is wrong, why didn't you update all of the other
do_sigaltstack() callers in the sparc port.  By your description they
should be wrong too.

But those cases don't matter like this one does.  This case here is
special, but you haven't described what is so unique about this case
which causes only it to need special handling.

Do you know the real reason why it fails without your change?
