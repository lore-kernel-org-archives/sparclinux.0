From: David Miller <davem@davemloft.net>
Date: Wed, 06 Jul 2011 15:04:24 +0000
Subject: Re: [PATCH][RFC] add SPARC support to i2c-ali1535
Message-Id: <20110706.080424.1322386503582835731.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "corentin.labbe" <corentin.labbe@geomatys.fr>
Date: Tue, 14 Jun 2011 14:59:41 +0200

> This patch enable i2c-ali1535 to works under SPARC architecture.
> 
> I wait for your comments/approval before sending it to the lm_sensors mailing lists.

Implementing this as a PCI driver doesn't make any sense.

It's be better to probe and fetch the register information
by using the openfirmware tree driver interfaces,
a table of "struct of_device_id", a "platform_driver" that
points to that of_device_id table, and a call to
platform_device_register() to register that platform_driver.

Also, even if you attach the I2C controller, you won't be
able to enumerate the underlying I2C devices properly.
The openfirmware device tree will need to be used in order
to do that as well.
