From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 31 Jan 2004 04:24:26 +0000
Subject: Re: 2.6.x SMP RED_state in prom_startcpu()
Message-Id: <20040131042426.GF624@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040131025909.GD624@holomorphy.com>
In-Reply-To: <20040131025909.GD624@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2004 at 10:07:59PM -0500, Ben Collins wrote:
>>> Which 2.6? I have latest 2.6 from bk booting on my 2xU2 just fine.

On Fri, Jan 30, 2004 at 07:17:21PM -0800, William Lee Irwin III wrote:
>> bk from a couple of days ago. Sorry, I needed to put the compiler in.
>> I tried with gcc-3.3.2 and gcc-3.2.3 releases as i386-linux-gnu to
>> sparc64-unknown-elf cross-compilers.

On Fri, Jan 30, 2004 at 10:52:12PM -0500, Ben Collins wrote:
> The cross-compilation may be the issue. Want to try a native build to
> make sure?

Trying to get luserspace bootstrapped enough to do this now. I'll start
pinging gcc hackers if that works and hence shows cross builds bust.


-- wli
