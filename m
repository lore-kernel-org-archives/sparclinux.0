From: Meelis Roos <mroos@linux.ee>
Date: Sun, 01 Dec 2013 08:16:50 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1312011006540.15816@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On 11/30/2013 08:31 PM, Meelis Roos wrote:
> > > Does the RED state exception trigger if you manually break to the prom
> > > command line and issue a boot command?
> > 
> > It seems I can not break from running kernel to PROM by sending break
> > from minicom. PROM itself reacts to my break (during memory test for
> > example) so it's Linux not accepting the break. I seem to remember it
> > having worked some time ago, although not when the kergel hung.
> 
> Argghh.
> 
> There were some changes to sunsab.c a couple of versions ago; maybe we
> broke it.
> 
> Can you confirm BRKs are being received with
> 'sudo cat /proc/tty/driver/serial'

In 3.12:

# cat /proc/tty/driver/sunsab 
serinfo:1.0 driver revision:
0: uart:SAB82532 V3.2 mmio:0x1FFF1400000 irq:5 tx:5163 rx:0 CTS|DSR|CD
1: uart:SAB82532 V3.2 mmio:0x1FFF1400040 irq:5 tx:0 rx:

cat /proc/sys/kernel/stop-a
1

# cat /proc/sys/kernel/reboot-cmd

(it was empty, so default "boot" should be used AFAIK)

-- 
Meelis Roos (mroos@linux.ee)
