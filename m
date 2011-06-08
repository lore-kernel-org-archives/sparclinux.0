From: Meelis Roos <mroos@linux.ee>
Date: Wed, 08 Jun 2011 12:40:33 +0000
Subject: 11 bogomips at 500 MHz?
Message-Id: <alpine.SOC.1.00.1106081531580.8911@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I see this on 500 MHz Fire V100.

[   59.253164] calibrate_delay_direct() timer_rate_maxU726 timer_rate_minU504 pre_start29128453 pre_end29184069
[   59.283196] calibrate_delay_direct() timer_rate_maxU721 timer_rate_minU503 pre_start29295308 pre_end29350920
[   59.313228] calibrate_delay_direct() timer_rate_maxU722 timer_rate_minU502 pre_start29462156 pre_end29517768
[   59.343261] calibrate_delay_direct() timer_rate_maxU723 timer_rate_minU505 pre_start29629002 pre_end29684616
[   59.373293] calibrate_delay_direct() timer_rate_maxU718 timer_rate_minU499 pre_start29795855 pre_end29851464
[   59.373349] Calibrating delay using timer specific routine.. 11.14 BogoMIPS (lpjU722)

11 bogomips seems ... slow. Older machines like Ultra 1, Ultra 5/10 show 
double the CPU clock speed as bogomips. Is it normal or is something 
clock-related broken?

cpu             : TI UltraSparc IIe (Hummingbird)
fpu             : UltraSparc IIe integrated FPU
pmu             : ultra12
prom            : OBP 4.0.18 2002/05/23 18:22
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0ClkTck      : 000000001dcd6500
MMU Type        : Spitfire

Netra X1 has it also similarly.

My dmesg logs go back to August 2008 and it has been the same always (at 
least at about 2.6.25), so it's not anything recent.

-- 
Meelis Roos (mroos@linux.ee)
