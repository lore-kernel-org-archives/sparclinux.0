From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 22 Feb 2004 09:11:50 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222091150.GI703@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Feb 21, 2004 at 11:25:33PM -0800, David S. Miller wrote:
> So, Will, did you test out the test kernel image I emailed to you the
> other day or did your spam filter eat it?

Unfortunately I never saw a test kernel image, so the spamfiltering bit
looks likely.


On Sat, Feb 21, 2004 at 11:25:33PM -0800, David S. Miller wrote:
> I want to figure out whether you have tool or kernel config issues
> before I even attempt to look at any of your crash traces.

I'll use any gcc or distro image I can drop in an nfsroot. I'm actually
trying to keep things set up to have fully disposable userspace, apart
from preserving a Solaris installation image as a hardware testing method.
(i.e. these boxen are intended as dedicated kernel hacking targets)


-- wli
