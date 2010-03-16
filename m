From: David Miller <davem@davemloft.net>
Date: Tue, 16 Mar 2010 22:24:37 +0000
Subject: Re: Debian Sparc 5.4 on Sun blade 2500
Message-Id: <20100316.152437.156742358.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
In-Reply-To: <1268768091.1768.29.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 16 Mar 2010 15:15:46 -0700 (PDT)

> Josip, please make sure this gets fixed, please get my
> sunxvr1000 driver added (attached) and then add:
> 
> CONFIG_FB_XVR500=y
> CONFIG_FB_XVR2500=y
> CONFIG_FB_XVR1000=y
> 
> to the config for sparc64.

Ok, further checking shows that lenny has XVR500 and XVR2500
enabled (doing a test install with a XVR-500 card right now)
but testing doesn't.
