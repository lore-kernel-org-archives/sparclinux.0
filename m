From: "C.Newport" <crn@netunix.com>
Date: Thu, 19 Aug 2004 23:04:52 +0000
Subject: Re: Sun4d SMP - retests - patch was not required
Message-Id: <200408200004.52831.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408192322.43126.crn@netunix.com>
In-Reply-To: <200408192322.43126.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 19 August 2004 11:28 pm, William Lee Irwin III wrote:

> > Could this mean that interrupts might be getting
> > misrouted to the wrong CPU or process ?.
>
> Yes, though we're really going to have to do more intense diagnostics
> (targeted printk'ing out of various bits of state etc.) to discover
> what's really happening with interrupts. Checking detailed dumps of
> interrupt routing state etc. vs. 2.2.x sound like a good first shot.

Just send me the tests and I will run them.
Comparisons with 2.2 will not help, there was no SMP capable version.

I will give 2.4.27 UP a good thrashing tomorrow - any instability there 
might give us some more clues.

