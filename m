From: David Miller <davem@davemloft.net>
Date: Mon, 10 Jul 2017 18:32:27 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <20170710.193227.632674662419801807.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 10 Jul 2017 13:48:46 +0200

> On Mon, Jul 10, 2017 at 02:46:19PM +0300, Meelis Roos wrote:
>> > > This is with Debian unstable 32-bit userland as of 2015 summer. It did 
>> > > not happen with 4.12.
>> > 
>> > Did you also perform tests with a current 64-bit userland?
>> 
>> No, for the current test this is not relevant since if the breakage 
>> happens with some userlan, it is kernel at fault.
> 
> Yes, but I think it's more interesting to perform such tests with
> current and maintained userland software.

Yes, let's make sure that 32-bit userland support in the kernel gets
even less testing, and gets even buggier over time.

I think people should test everything, as much as possible.

