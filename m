From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 19 Aug 2004 23:09:23 +0000
Subject: Re: Sun4d SMP - retests - patch was not required
Message-Id: <20040819230923.GF11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408192322.43126.crn@netunix.com>
In-Reply-To: <200408192322.43126.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 19 August 2004 11:28 pm, William Lee Irwin III wrote:
>> Yes, though we're really going to have to do more intense diagnostics
>> (targeted printk'ing out of various bits of state etc.) to discover
>> what's really happening with interrupts. Checking detailed dumps of
>> interrupt routing state etc. vs. 2.2.x sound like a good first shot.

On Fri, Aug 20, 2004 at 12:04:52AM +0100, C.Newport wrote:
> Just send me the tests and I will run them.
> Comparisons with 2.2 will not help, there was no SMP capable version.
> I will give 2.4.27 UP a good thrashing tomorrow - any instability there 
> might give us some more clues.

These aren't tests per se, they're C code to print out extra
information. This generally needs to be done by hand and with some
insight into what you're looking at so as to find the relevant things
to print. With no extant working SMP sun4d kernel there's nothing to
really compare against, so I think we're going to have to do something
else here anyway, though some similar information may be useful for it.


-- wli
