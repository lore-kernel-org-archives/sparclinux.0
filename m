From: David Miller <davem@davemloft.net>
Date: Wed, 08 Jun 2011 21:58:35 +0000
Subject: Re: 11 bogomips at 500 MHz?
Message-Id: <20110608.145835.2044972158884111340.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1106081531580.8911@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1106081531580.8911@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 8 Jun 2011 15:40:33 +0300 (EEST)

> I see this on 500 MHz Fire V100.
> 
> [   59.253164] calibrate_delay_direct() timer_rate_maxU726 timer_rate_minU504 pre_start29128453 pre_end29184069
> [   59.283196] calibrate_delay_direct() timer_rate_maxU721 timer_rate_minU503 pre_start29295308 pre_end29350920
> [   59.313228] calibrate_delay_direct() timer_rate_maxU722 timer_rate_minU502 pre_start29462156 pre_end29517768
> [   59.343261] calibrate_delay_direct() timer_rate_maxU723 timer_rate_minU505 pre_start29629002 pre_end29684616
> [   59.373293] calibrate_delay_direct() timer_rate_maxU718 timer_rate_minU499 pre_start29795855 pre_end29851464
> [   59.373349] Calibrating delay using timer specific routine.. 11.14 BogoMIPS (lpjU722)
> 
> 11 bogomips seems ... slow. Older machines like Ultra 1, Ultra 5/10 show 
> double the CPU clock speed as bogomips. Is it normal or is something 
> clock-related broken?

It has to do with what clock source we're using for timer interrupt
generation, and for this CPU we use the system TICK value which runs
at the bus clock speed and not the CPU clock speed.

Absolutely no interpretation of the bogomips value should ever be
made.
