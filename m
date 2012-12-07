From: David Miller <davem@davemloft.net>
Date: Fri, 07 Dec 2012 17:30:57 +0000
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c and spi
Message-Id: <20121207.123057.2230821059287428618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
	<20121204.161001.1397661306369063374.davem@davemloft.net>
	<CACxGe6t4YcSuh04UjoYqFp355iLa6ECc5G+Y1TP3kxsL48c6jQ@mail.gmail.com>
In-Reply-To: <CACxGe6t4YcSuh04UjoYqFp355iLa6ECc5G+Y1TP3kxsL48c6jQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 4 Dec 2012 21:49:26 +0000

> On Tue, Dec 4, 2012 at 9:10 PM, David Miller <davem@davemloft.net> wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>> Date: Tue, 4 Dec 2012 14:44:57 +0000
>>
>>> On Tue, Dec 4, 2012 at 2:09 PM, Andreas Larsson <andreas@gaisler.com> wrote:
>>>> This series removes the dependency on !SPARC for OF_I2C and removes the
>>>> depencency of !defined(CONFIG_SPARC) for the function
>>>> of_register_spi_devices. I find no reason for these to be unavailable
>>>> for sparc.
>>>>
>>>> I am not sure if these should go through the sparc tree or the
>>>> corresponding subsystem trees.
>>>
>>> They should go through the subsystem trees.
>>
>> I'll take this into the sparc tree after some build testing, thanks.
> 
> I'd prefer to take the SPI one through my tree, but I won't get my
> knickers in a knot if you insist.

That's fine:

Acked-by: David S. Miller <davem@davemloft.net>
