From: David Miller <davem@davemloft.net>
Date: Thu, 24 Mar 2011 23:36:04 +0000
Subject: Re: [PATCH v3] Fix multiple RTC detections on SUN4D
Message-Id: <20110324.163604.220073550.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1010170628050.5462@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1010170628050.5462@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sat, 26 Feb 2011 11:04:23 +0100 (CET)

> During the preparation for testing the recent changes made to the SUN4D
> specific code in the kernel by Sam Ravnborg the following was discovered:
> 
> Since the removal of of_platform_bus_type (commit: eca3930163ba8884060ce9d9ff5ef0d9b7c7b00f )
> multiboard SUN4Ds have not been able to boot. The kernel crashes due to a
> zero-pointer error encountered when registering multiple M48T59 RTCs
> (There is one on each board).
> 
> A patch for the was previously submitted, but the problem was not a
> serious at that time, as it would only generate warnings. Now the kernel
> will crash and stop executing before the serial console has been started.
> (Crash output can be viewed by using the -p boot flag)
> 
> Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>

Applied, sorry for taking so long.
