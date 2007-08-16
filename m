From: David Miller <davem@davemloft.net>
Date: Thu, 16 Aug 2007 03:52:35 +0000
Subject: Re: Physical cpu number on UltrasparcT1
Message-Id: <20070815.205235.59657574.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
In-Reply-To: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Thu, 16 Aug 2007 15:42:58 +1200

> Seems not of too much help?
> 
> What should I do then?

If you can't decode that table and see that the virtual
cpu IDs are the same as the physical cpu IDs, perhaps
you should take my second recommendation and build
a more recent kernel so you can take a look at the
machine description and the SMT/MC scheduling groups.
