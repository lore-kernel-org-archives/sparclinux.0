From: Bob Breuer <breuerr@mc.net>
Date: Fri, 11 Feb 2005 03:05:29 +0000
Subject: Re: [2.6 PATCH] syntax errors by smp_{mb,rmb,wmb} on sparc32
Message-Id: <420C20F9.5070701@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502092331420.4099@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502092331420.4099@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
>  
>  #define nop() __asm__ __volatile__ ("nop");
                                             ^^^
Looks like the nop macro needs to have it's semicolon taken away also.

Bob
