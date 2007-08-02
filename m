From: David Miller <davem@davemloft.net>
Date: Thu, 02 Aug 2007 22:07:50 +0000
Subject: Re: Ultra 2 with nvram problems
Message-Id: <20070802.150750.93642675.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070802220327.20940@gmx.net>
In-Reply-To: <20070802220327.20940@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Ulrich Teichert" <Ulrich.Teichert@gmx.de>
Date: Fri, 03 Aug 2007 00:03:27 +0200

> Has anybody seen symptoms like this before? I assume the nvram battery is
> empty and replacing it should cure all this, but before I search all ebay
> for these precious jewels, I'd like to know if a replacement will get me
> anywhere.

Yes, that's the problem.  The NVRAM isn't making forward progress
and this jams up the RTC driver.

A replacement will definitely help.
