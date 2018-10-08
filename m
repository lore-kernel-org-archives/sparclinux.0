From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 08 Oct 2018 18:42:14 +0000
Subject: Re: [GIT] Sparc
Message-Id: <5223d48f-3947-4b05-2e40-77a93177fc96@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave!

On 10/8/18 8:48 AM, David Miller wrote:
> I've been moving so haven't had access to my Sparc boxes during this
> time.  That's been resolved, and now I can get the patches flowing
> again.
Great to hear you're back!

Can I bring this bug [1] back to your attention which allowed a regular
userland application to crash the kernel? Would be interesting to see
whether you're able to reproduce the issue.

The offending binary is attached to the bug report. It's a test program
from the testsuite of the Free Pascal Compiler which was recently ported
to sparc64.

Thanks,
Adrian

> [1] https://bugzilla.kernel.org/show_bug.cgi?id 0625

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
