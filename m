From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 04 Oct 2012 22:37:29 +0000
Subject: Re: [RESEND PATCH 2/2] sparc64: Fix strace hiccups when force_successful_syscall() triggers.
Message-Id: <20121004223729.GL23473@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.174854.48578929410140312.davem@davemloft.net>
In-Reply-To: <20121004.174854.48578929410140312.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Oct 04, 2012 at 05:48:54PM -0400, David Miller wrote:
> 
> [ Again, resending hoping it actually hits the list this time. ]
> 
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> When force_successful_syscall() triggers, the syscall return status
> reported the ptrace applications gets garbled.
> 
> Fix this by reordering the events and tests in the ret_sys_call path.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

... and my s-o-b as well -

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
