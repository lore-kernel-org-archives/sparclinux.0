From: David Miller <davem@davemloft.net>
Date: Fri, 08 Aug 2014 17:33:52 +0000
Subject: Re: [PATCH sparc] ldc_connect() should not return EINVAL when handshake is in progress.
Message-Id: <20140808.103352.2281805078134049257.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140801135040.GE19031@oracle.com>
In-Reply-To: <20140801135040.GE19031@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David L Stevens <david.stevens@oracle.com>
Date: Fri, 08 Aug 2014 09:55:55 -0400

> On 08/08/2014 01:26 AM, David Miller wrote:
> 
>> Now, besides taking the error path in vnet_start_xmit() and dropping
>> the packet, we need to think about what we should do subsequently when
>> this condition triggers.
>> 
>> We probably want to take the carrier down via netif_carrier_off(), and
>> then when we see the head pointer advancing (I guess via
>> vnet_event()'s logic), the networking driver can netif_carrir_on() in
>> response.
> 
> Aren't we talking about one ldc port (out of many) for the device here?
> I'm not sure we want to drop carrier if only one port isn't making
> progress, unless maybe that's the only switch port.

Right now we already are stopping the entire TX queue of the device if
just one port backs up.

Effectively the link is down at that point, and as long as it persists
no traffic is going to pass over the device.

The problem with not taking the carrier off is that the qdisc layer is
going to spam messages into the log each time the TX watchdog timer
goes off.
