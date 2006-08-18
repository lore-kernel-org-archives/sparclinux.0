From: David Miller <davem@davemloft.net>
Date: Fri, 18 Aug 2006 01:10:56 +0000
Subject: Re: [PATCH] sunlance probing problem
Message-Id: <20060817.181056.71088906.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44dcfea4406f9@wp.pl>
In-Reply-To: <44dcfea4406f9@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 12 Aug 2006 15:20:55 +0200

> The patch skips probing of the "le" device if it is a child of
> "ledma" or "lebuffer".
> 
> Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)

If you return "0" as the error, the caller in the device probing layer
grabs a reference to the device which will be a leak of the undelying
of_device object.

A better way to fix this is probably to only match "le" and have
the probe code check the device parent for "ledma" or "lebuffer".
You should be able to confine all of your changes to the probe
match table and sunlance_sbus_probe().

Could you implement it like that and give it a test?

Thanks.

