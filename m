From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 14 Jan 2005 04:19:06 +0000
Subject: Re: dump_stack missing on sparc32
Message-Id: <20050114041906.GE6101@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 13, 2005 at 10:24:50PM -0600, Bob Breuer wrote:
> The sparc32 specific dump_stack function is missing, but there is a 
> show_stack in arch/sparc/kernel/process.c.  Should it be easy enough to 
> connect these together, or are there known bugs that prevent the use of 
> dump_stack?

dump_stack() just calls show_stack() with hardcoded arguments on most
architectures.


-- wli
