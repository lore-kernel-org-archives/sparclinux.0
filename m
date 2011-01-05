From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 05 Jan 2011 23:42:49 +0000
Subject: Re: [PATCH 0/4] sparc: drop SBUS ifdefs
Message-Id: <AANLkTik+hZ+cLv8H1QAeKSCrrsRW=RRfiqr-ut3O1KRe@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105210217.GA22415@merkur.ravnborg.org>
In-Reply-To: <20110105210217.GA22415@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 6, 2011 at 10:36, David Miller <davem@davemloft.net> wrote:
> From: Julian Calaby <julian.calaby@gmail.com>
> Date: Thu, 6 Jan 2011 10:23:43 +1100
>
>> And beyond that, keeping these (unnecessary) #ifdefs is good
>> documentation - it makes it obvious that these drivers require sbus to
>> function.
>
> It should be buildable on any platform that has CONFIG_OF support,
> as all of the SBUS drivers only use generic OF and dma_*() interfaces.
>
> And this has value because it increases build testing.

Oh, yes, forgot that =)

That said, sunhme has SBUS conditionals around calls to
sbus_can_burst64() and sbus_can_dma_64bit() - I'm not sure if the
other drivers also use similar functions to determine what they can /
should do and whether this would break things.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
