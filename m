From: Meelis Roos <mroos@linux.ee>
Date: Wed, 04 Mar 2009 11:57:11 +0000
Subject: Re: esp scsi problem on shutdown - sunhme related?
Message-Id: <Pine.SOC.4.64.0903041356270.12608@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> What does /proc/interrupts look like on this system when
> everything is up and running?

Seems they have different irqs:

           CPU6       CPU7       CPU10       CPU11       CPU14       CPU15
  0:       5046       3408       4041       3274       2602       2815     <NULL>  timer
  2:       3063          0          0          0          0          0      sun4u  zs
  4:          0          0          0          0          0          0      sun4u  SYSIO_UE
  5:          0          0          0          0          0          0      sun4u  SYSIO_CE
  6:          0          0          0          0          0          0      sun4u  SYSIO_SBERR
 12:          0          0          0          0          0          0      sun4u  SYSIO_UE
 13:          0          0          0          0          0          0      sun4u  SYSIO_CE
 14:          0          0          0          0          0          0      sun4u  SYSIO_SBERR
 18:        381          0          0          0          0          0      sun4u  eth0
 19:       6476          0          0          0          0          0      sun4u  ESP
NMI:          0          0          0          0          0          0      Non-maskable interrupts

-- 
Meelis Roos (mroos@linux.ee)
