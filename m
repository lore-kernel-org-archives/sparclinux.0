From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 17 Nov 2004 03:47:40 +0000
Subject: Re: hypersparc dvma aliasing
Message-Id: <20041117034740.GO3217@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <419AB742.1000103@mc.net>
In-Reply-To: <419AB742.1000103@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Nov 16, 2004 at 09:35:03PM -0600, Bob Breuer wrote:
> Here's the preliminary patch.  This time around, both the hme
> and esp drivers are working for me.  This replaces my previous
> patch and is against the vanilla 2.6.9 kernel.  I've tried to
> reduce the amount of unnecessary cache flushing, therefore this
> will need some testing on non-hypersparc cpus also.  It needs
> some cleanup yet, and will be rediffed against a later kernel.
> I'm looking for comments and feedback.

I'll spin this up on some sparc32 boxen.


-- wli
