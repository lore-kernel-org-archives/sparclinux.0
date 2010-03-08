From: David Miller <davem@davemloft.net>
Date: Mon, 08 Mar 2010 18:53:18 +0000
Subject: Re: [PATCH] Remove slash in QlogicPTI irq name
Message-Id: <20100308.105318.68421217.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1003081809380.26387@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1003081809380.26387@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 8 Mar 2010 20:23:20 +0200 (EET)

> qlogicpti driver registers its irq with a name containing slash.
> This results in 
> 
> [   71.049735] WARNING: at fs/proc/generic.c:316 __xlate_proc_name+0xa8/0xb8()
> [   71.132815] name 'Qlogic/PTI'
> 
> because proc_mkdir with the name of the irq fails. Fix it by just 
> removing the slash from irq name. Discovered and tested on real hardware 
> (Sun Ultra 1).
> 
> Signed-off-by: Meelis Roos <mroos@linux.ee>

Applied, thanks a lot!
