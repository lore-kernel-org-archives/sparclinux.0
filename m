From: Meelis Roos <mroos@linux.ee>
Date: Tue, 27 Jun 2017 13:21:16 +0000
Subject: Access to older 64-bit sparcs for developers
Message-Id: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I see a lot of new development activity on sparclinux, that is great.

I also see different views on supporting older hardware on current 
kernels, and testing on old ultrasparcs seens to be one of the issues.

I have most of my sparclinux testbed in DMZ-s and I can make them 
available to any developers who want it, along with root access and 
built in management (if any).

Site 1: Ultra 1 143 MHz and Blade 100.

Third one is slowly rotating between E3500/E250/E450 because of power 
constraints so it is not stable at the moment.

Site 2: Ultra 2 (2x400), E220R (2 CPUs), T1-105, T1-200, V120, V210, 
V240, V440, V245, T1000, T2000, T5120.

I can add Netra X1 and V100 with some effort (relocating to the DMZ).

Planning to set up and add V445, T5140, E280R, Blade 1500.

In the queue of getting fixed (or rebuilt from parts of multiple 
machines): U5, U10, Blade 150, E3000, E3800, V480, V880, Netra T2000, 
Netra T5220 and Netra 240. These are all future stuff but if there is 
any recommendation on order of these, I might reshuffle them.

Remote managenet access is also possible for the machines that have a 
RSC/LOM/ALOM. For the machines that are without hardware management 
interface, restart is possible in site 2, site 1 is slow with respect to 
hands-on.

Both sites are behind IPv4 NAT and have native IPv6, so for IPv4 access, 
SSH through the gateway is needed and that requires key based access.

Please refer to ther prtconf repo for sample configs of the models, to 
see what CPUs and OF stuff there are (most models have a fixed CPU 
family but not all).

-- 
Meelis Roos (mroos@linux.ee)
