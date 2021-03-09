From: David Miller <davem@davemloft.net>
Date: Tue, 09 Mar 2021 19:08:12 +0000
Subject: Re: [GIT] SPARC
Message-Id: <20210309.110812.234617387417457658.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20210308.154619.729170517586257571.davem@davemloft.net>
        <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
In-Reply-To: <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: glaubitz@physik.fu-berlin.de
Cc: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 9 Mar 2021 01:19:05 +0100

> Hi Dave!
> 
> On 3/9/21 12:46 AM, David Miller wrote:
>> Just some more random bits from Al,  including a conversion over to generic exytables.
> 
> Is there a chance we could include this important fix by Rob Gardner for 5.12 as well?
> 
>> https://marc.info/?l=linux-sparc&m1457847223456&w=2
> 
> It fixes a hard kernel crash under certain loads which we have seen in Debian quite frequently.

I'll ake sure that gets into my next pull req, thanks.
