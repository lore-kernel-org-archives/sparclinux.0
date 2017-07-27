From: Pierre Muller <pierre@freepascal.org>
Date: Thu, 27 Jul 2017 13:25:11 +0000
Subject: Re: Reproducer for sparc64 kernel lock-up bug
Message-Id: <391f88a1-6430-79e7-e9e0-8f3109d3b0fa@freepascal.org>
List-Id: <sparclinux.vger.kernel.org>
References: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
In-Reply-To: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



Le 27/07/2017 à 01:41, David Miller a écrit :
> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date: Fri, 21 Jul 2017 16:28:01 +0200
> 
>> When running the attached, statically linked binary on a recent
>> kernel, the kernel locks up with:
> 
> Thanks a lot, as soon as I sort through the RCU stall bug I'll take
> a close look at this!
> 

  Hi all,

  stadler is crashing less since we corrected the rt_sigaction
(SIGBUS value was wrong, equal to SIGEMT,apparently an emulator trap).

  But we still get warnings about memory exposure,
RCU are also quite numerous, and after a while the cron daemon doesn't
work correctly anymore,
and then even a simple sleep command does not finish when the
time is over.

  Does anyone have an idea how the kernel can start
to miss to stop sleep command?

  Is here a simpler way to fix such issues
than to restart the machine?

Thanks in advance,

Pierre Muller
