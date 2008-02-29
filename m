From: David Miller <davem@davemloft.net>
Date: Fri, 29 Feb 2008 19:57:14 +0000
Subject: Re: bbc_envctrl & sunblade1000 temp/fan monitoring
Message-Id: <20080229.115714.176494057.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY123-W223997AE674E1FB857BC07D1260@phx.gbl>
In-Reply-To: <BAY123-W223997AE674E1FB857BC07D1260@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Eric Brower" <ebrower@gmail.com>
Date: Fri, 29 Feb 2008 11:46:19 -0800

> There are some experimental, out-of-kernel drivers for SUNW,envctrl
> (E450) and SUNW,envctrltwo (E250) located here:
> 
>   http://www.david-web.co.uk/index.php?p=envctrl
> 
> This may provide some inspiration on using sysfs for accessing sensors
> information.

I took a quick look at this stuff and wouldn't mind if the
kernel bits were submitter formally as a patch with a proper
changelog and signoffs :-)

I'll cleanup the coding style and deal with compiler warnings
and any build problems etc.

Using the I2C layer properly was long on my todo list for the
BBC envctrl bits.

Thanks.
