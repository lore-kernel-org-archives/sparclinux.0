From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 06 May 2015 11:53:39 +0000
Subject: Re: Ultra1 warning in 4.0.0-rc4-00048-gc586165
Message-Id: <20150506115339.GC2358@fuloong-minipc.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1503241040040.9652@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1503241040040.9652@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Tue, Mar 24, 2015 at 11:53:58AM -0400, David Miller wrote:
> From: Meelis Roos <mroos@linux.ee>
> Date: Tue, 24 Mar 2015 10:44:52 +0200 (EET)
> 
> > Just started to compile todays git with memmove fixes on many sparcs and 
> > got the following warning on Ultra 1 during git or make:
> > 
> > [435962.279707] BUG: Bad rss-counter state mm:fffff800322b72e0 idx:0 val:7
> > [435962.357276] BUG: non-zero nr_ptes on freeing mm: 1
> > 
> > This is the first time I remember having seen this. After boot into 
> > 4.0.0-rc4-00048-gc586165 I performed only debian upgrade and that was 
> > fine. No load since then.
> 
> That's unfortunate, I thought we killed this bug :-/
> 
> Oh well, more digging to do.

I also got this on Ultra 10 during GCC bootstrap with 4.1-rc2:

[13189.466077] BUG: Bad rss-counter state mm:fffff8001f3c2d80 idx:1 val:3
[13189.543306] BUG: non-zero nr_ptes on freeing mm: 1

A.
