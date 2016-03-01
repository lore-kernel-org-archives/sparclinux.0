From: David Miller <davem@davemloft.net>
Date: Tue, 01 Mar 2016 16:43:33 +0000
Subject: Re: [PATCH v7] Add sun4v_wdt watchdog driver
Message-Id: <20160301.114333.1678437570401923609.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1454089178-29836-1-git-send-email-wim.coekaerts@oracle.com>
	<20160131.110645.985983227353861690.davem@davemloft.net>
	<20160301153436.GA27836@spo001.leaseweb.nl>
In-Reply-To: <20160301153436.GA27836@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wim@iguana.be
Cc: wim.coekaerts@oracle.com, linux@roeck-us.net, linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org

From: Wim Van Sebroeck <wim@iguana.be>
Date: Tue, 1 Mar 2016 16:34:37 +0100

>> From: Wim Coekaerts <wim.coekaerts@oracle.com>
>> Date: Fri, 29 Jan 2016 09:39:38 -0800
>> 
>> > This driver adds sparc hypervisor watchdog support. The default
>> > timeout is 60 seconds and the range is between 1 and
>> > 31536000 seconds. Both watchdog-resolution and
>> > watchdog-max-timeout MD properties settings are supported.
>> > 
>> > Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
>> 
>> Applied, thanks.
> 
> This also has my signed-off-by as watchdog maintainer.
> 
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> I presume you will take this via the SUN architecture tree?

Yes and I already send a pull request with this in it last night
to Linus.
