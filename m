From: David Miller <davem@davemloft.net>
Date: Wed, 25 Nov 2009 06:40:47 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091124.224047.220052133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 23 Nov 2009 23:40:28 +0100

> On Mon, Nov 23, 2009 at 02:32:04PM -0800, David Miller wrote:
>> Something like that.  It could also just be compiled "differently" by
>> your gcc and expose some race or bug.
> 
> OK. Yours has gcc 4.2.4, and our ones have gcc 4.3.2 (that we shipped
> as "stable" :)
> 
> I also just tried a newer packaged image, and it has the same issue.

I just tossed lenny onto my main build system and I will try to
reproduce this and track it down.
