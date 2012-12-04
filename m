From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 04 Dec 2012 14:44:57 +0000
Subject: Re: [PATCH 0/2] sparc: Enable OF functionality for sparc for i2c and spi
Message-Id: <CACxGe6sw0zU0NcXw1gjMZka4WyTZgT4heF3r4k0QPHbfcPzbiw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1354630178-25387-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Larsson <andreas@gaisler.com>
Cc: David Miller <davem@davemloft.net>, Wolfram Sang <w.sang@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, spi-devel-general@lists.sourceforge.net, Linux I2C <linux-i2c@vger.kernel.org>, software@gaisler.com

On Tue, Dec 4, 2012 at 2:09 PM, Andreas Larsson <andreas@gaisler.com> wrote:
> This series removes the dependency on !SPARC for OF_I2C and removes the
> depencency of !defined(CONFIG_SPARC) for the function
> of_register_spi_devices. I find no reason for these to be unavailable
> for sparc.
>
> I am not sure if these should go through the sparc tree or the
> corresponding subsystem trees.

They should go through the subsystem trees.

What build testing have you done on these patches?

g.
