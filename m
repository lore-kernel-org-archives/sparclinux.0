From: David Miller <davem@davemloft.net>
Date: Mon, 04 Aug 2014 23:54:48 +0000
Subject: Re: [PATCH] bbc-i2c: Fix BBC I2C envctrl on SunBlade 2000
Message-Id: <20140804.165448.333926950757251438.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201408031544.52481.cat.schulze@alice-dsl.net>
In-Reply-To: <201408031544.52481.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 3 Aug 2014 15:44:52 +0200

> From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
> 
> Fix regression in bbc i2c temperature and fan control on some Sun systems
> that causes the driver to refuse to load due to the bbc_i2c_bussel resource not
> being present on the (second) i2c bus where the temperature sensors and fan
> control are located. (The check for the number of resources was removed when
> the driver was ported to a pure OF driver in mid 2008.)
> 
> Patch applies to 3.16-rc6.
> 
> Signed-off-by: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

Applied and queued up for -stable, thanks.
