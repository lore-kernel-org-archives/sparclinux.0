From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 08 Feb 2004 05:06:10 +0000
Subject: Re: 2.6.x SMP RED_state in prom_startcpu()
Message-Id: <20040208050610.GB699@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040131025909.GD624@holomorphy.com>
In-Reply-To: <20040131025909.GD624@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2004 at 10:52:12PM -0500, Ben Collins wrote:
>> The cross-compilation may be the issue. Want to try a native build to
>> make sure?

On Fri, Jan 30, 2004 at 08:24:26PM -0800, William Lee Irwin III wrote:
> Trying to get luserspace bootstrapped enough to do this now. I'll start
> pinging gcc hackers if that works and hence shows cross builds bust.

I got a native toolchain going. 2.4.24 flies with the 2nd cpu online.
2.6.x fails in prom_startcpu(). Cross-builds fail for both.


-- wli
