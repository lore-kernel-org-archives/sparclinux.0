From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 12 Aug 2007 14:33:45 +0000
Subject: Re: Sun4c interrupt controller, MMU, IOMMU?
Message-Id: <Pine.LNX.4.61.0708121526490.32464@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
In-Reply-To: <f43fc5580708120042m5f2fe544k83aaf00810efc070@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

>
> All DMA is translated by the cpu's MMU as if it were a memory
> reference made by the cpu itself.  Any missed DMA translation watchdog
> resets the cpu.

I am getting a watchdog reset as soon as I enable interrupts after 
rebooting the kernel from SunOS or a prom_halt. Could in-proper DMA 
settings be the cause of this?
After the watchdog reset or a powre-up reset, there is no problem booting 
Linux !.

Note: I am using SunOS4.1.1 boot so the kernel mappings for linux are
not what the loader is expecting.

SunOS does not have this problem but they hard code things so that they 
can get interrupts etc. up and running very much earlier on than Linux so 
it is very dificult to compare the sequence of events during boot for the 
two kernels.

