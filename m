From: David Miller <davem@davemloft.net>
Date: Tue, 05 Aug 2014 05:40:56 +0000
Subject: Re: [PATCH] sparc64: Guard against flushing openfirmware mappings.
Message-Id: <20140804.224056.1561995911715380938.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140804.201710.101327918842040424.davem@davemloft.net>
In-Reply-To: <20140804.201710.101327918842040424.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 5 Aug 2014 13:51:37 +1000

> Stupid question (because I know it'll never happen) but wouldn't it be
> better to make this even more explicit and handle cases where the
> range starts or ends within the OpenFirmware range too?

I guess we could make it more strict, but the checks we've used cover
any case that the problematic vmalloc code can generate.
