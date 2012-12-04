From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 04 Dec 2012 15:01:51 +0000
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c and spi
Message-Id: <50BE105F.3080403@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com> <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
In-Reply-To: <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Miller <davem@davemloft.net>, Wolfram Sang <w.sang@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, spi-devel-general@lists.sourceforge.net, Linux I2C <linux-i2c@vger.kernel.org>, software@gaisler.com

On 2012-12-04 15:44, Grant Likely wrote:
> On Tue, Dec 4, 2012 at 2:09 PM, Andreas Larsson <andreas@gaisler.com> wrote:
>> This series removes the dependency on !SPARC for OF_I2C and removes the
>> depencency of !defined(CONFIG_SPARC) for the function
>> of_register_spi_devices. I find no reason for these to be unavailable
>> for sparc.
>>
>> I am not sure if these should go through the sparc tree or the
>> corresponding subsystem trees.
>
> They should go through the subsystem trees.
>
> What build testing have you done on these patches?

I have built under sparc32 (leon sparc to be specific) and have 
confirmed that of_register_spi_devices and of_i2c_register_devices works 
fine.

Cheers,
Andreas

