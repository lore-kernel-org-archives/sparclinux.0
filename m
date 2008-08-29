From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 08:12:55 +0000
Subject: Re: [PATCH 9/12]: rtc: Add Sun4V hypervisor RTC driver.
Message-Id: <20080829.011255.45357384.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080828.230943.37124120.davem@davemloft.net>
In-Reply-To: <20080828.230943.37124120.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 23:09:43 -0700 (PDT)

> rtc: Add Sun4V hypervisor RTC driver.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Testing this driver revealed that while some machines
have the proper openfirmware node for this device,
others don't.

So I'll rework this to be a platform style driver,
just like rtc-starfire
