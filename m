From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 28 Jul 2004 23:53:29 +0000
Subject: Re: SMP support in 2.6.x kernel for sparc32
Message-Id: <20040728235329.GE2334@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <001301c474db$af707860$3c01a8c0@cascade>
In-Reply-To: <001301c474db$af707860$3c01a8c0@cascade>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jul 28, 2004 at 03:06:03PM -0700, William Lee Irwin III wrote:
>>> I expect that this patch will not qualify as stable, esp. given that

On Wed, Jul 28, 2004 at 03:35:35PM -0700, Keith M Wesolowski wrote:
>> Understatement of the year.  Note abuse of prom_printf, #if 0, and
>> randomly commented-out lines.  If someone sent me this patch as
>> anything other than a curiosity item or cautionary example, I'd K-line
>> him.  YHBW.
>> OTOH, if someone wants to clean it up and get it current, that might
>> be useful.  I think joshk may have a slightly improved version he was
>> using for a while.  Perhaps he can comment here.

On Wed, Jul 28, 2004 at 03:42:30PM -0700, William Lee Irwin III wrote:
> Thanks for the sterner warning. I've got work to do here, but I'm only
> about 36 hours out from OLS and am still trying to catch up with work
> and the rest of email.

I just rediffed the smp patch by brute force vs. 2.6.8-rc2. I'll spin
it up on 3x hypersparc if it turns out the box is actually functional
and see where it explodes sometime in the next 72 hours.


-- wli
