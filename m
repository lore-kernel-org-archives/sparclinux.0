From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 17 Jul 2005 13:32:22 +0000
Subject: Re: [2.6 patch] sparc: remove the useless APM_RTC_IS_GMT option
Message-Id: <20050717133222.GF3613@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20050715203632.GD18059@stusta.de> <1121460211.2755.114.camel@localhost.localdomain>
In-Reply-To: <1121460211.2755.114.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom 'spot' Callaway <tcallawa@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 03:43:31PM -0500, Tom 'spot' Callaway wrote:
> On Fri, 2005-07-15 at 22:36 +0200, Adrian Bunk wrote:
> > I can't see any effect of this option outside the i386-specific APM 
> > code.
> 
> Doesn't the Javastation potentially use this?

I don't know whether the Javastation supports APM, but the whole APM 
code in the kernel is currently only available on i386.

> ~spot

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

