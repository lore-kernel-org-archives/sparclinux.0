From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 06 Dec 2004 13:55:06 +0000
Subject: Re: 2.6.8-1-sparc64 nanosleep does not restart if interrupted by
Message-Id: <1102341305.15654.188.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <1102294691.15654.137.camel@duncow>
In-Reply-To: <1102294691.15654.137.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2004-12-06 at 05:44, David S. Miller wrote:
> Good catch Richard.  In fact all restart block handling is hosed
> on sparc.  It's because of the return from syscall check for
> error cases, the return value errno comparison is off by one.
> 
> This should fix it, and it does for me on sparc64 for your test
> program.
Thanks, that fixes it (tested with nanotest in 32 and 64 bit and
my original tail -f testcase. However I have a comment on the fix.

What about the NFSv3 values(521-530) that are defined in
include/errno.h? Surely these could be returned by the kernel so the fix
should include them i.e. use EIOCBRETRY. Indeed would it be better to
have a EMAXERRNO value that could be used with a comment in errno.h to
make it clear.

Richard

-- 
richm@oldelvet.org.uk

