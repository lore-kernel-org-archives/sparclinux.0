From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 05 Jan 2010 16:41:45 +0000
Subject: Re: [RFC][PATCH 14/14] Convert sparc to read/update_persistent_clock
Message-Id: <4B436BC9.5020102@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1261540762.3508.61.camel@localhost.localdomain>	 <1261540826.3508.62.camel@localhost.localdomain>	 <1261540902.3508.63.camel@localhost.localdomain>	 <1261540988.3508.64.camel@localhost.localdomain>	 <1261541054.3508.65.camel@localhost.localdomain>	 <1261541130.3508.66.camel@localhost.localdomain>	 <1261541188.3508.67.camel@localhost.localdomain>	 <1261541286.3508.69.camel@localhost.localdomain>	 <1261541342.3508.70.camel@localhost.localdomain>	 <1261541415.3508.71.camel@localhost.localdomain>	 <1261541491.3508.72.camel@localhost.localdomain>	 <1261541567.3508.73.camel@localhost.localdomain>	 <1261541643.3508.74.camel@localhost.localdomain>	 <1261541703.3508.75.camel@localhost.localdomain> <1261541771.3508.76.camel@localhost.localdomain>
In-Reply-To: <1261541771.3508.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Hi,

john stultz wrote:
> This patch converts the sparc architecture to use the generic
> read_persistent_clock and update_persistent_clock interfaces, reducing
> the amount of arch specific code we have to maintain, and allowing for
> further cleanups in the future.
>
> I have not built or tested this patch, so help from arch maintainers
> would be appreciated.
>
>   
> Signed-off-by: John Stultz <johnstul@us.ibm.com>
>   

The sparc32 patch does not build because you forgot to remove the
last_rtc_update variable declaration:

arch/sparc/kernel/time_32.c: In function 'timer_interrupt':
arch/sparc/kernel/time_32.c:94: warning: unused variable 'last_rtc_update'

Best regards,
Kristoffer Glembo

