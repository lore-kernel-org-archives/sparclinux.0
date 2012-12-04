From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 04 Dec 2012 21:49:26 +0000
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c and spi
Message-Id: <CACxGe6t4YcSuh04UjoYqFp355iLa6ECc5G+Y1TP3kxsL48c6jQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
 <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com> <20121204.161001.1397661306369063374.davem@davemloft.net>
In-Reply-To: <20121204.161001.1397661306369063374.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>, Wolfram Sang <w.sang@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, spi-devel-general@lists.sourceforge.net, Linux I2C <linux-i2c@vger.kernel.org>, software <software@gaisler.com>

On Tue, Dec 4, 2012 at 9:10 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Tue, 4 Dec 2012 14:44:57 +0000
>
>> On Tue, Dec 4, 2012 at 2:09 PM, Andreas Larsson <andreas@gaisler.com> wrote:
>>> This series removes the dependency on !SPARC for OF_I2C and removes the
>>> depencency of !defined(CONFIG_SPARC) for the function
>>> of_register_spi_devices. I find no reason for these to be unavailable
>>> for sparc.
>>>
>>> I am not sure if these should go through the sparc tree or the
>>> corresponding subsystem trees.
>>
>> They should go through the subsystem trees.
>
> I'll take this into the sparc tree after some build testing, thanks.

I'd prefer to take the SPI one through my tree, but I won't get my
knickers in a knot if you insist.

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
