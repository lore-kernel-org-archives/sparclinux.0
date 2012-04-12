From: David Miller <davem@davemloft.net>
Date: Thu, 12 Apr 2012 19:22:10 +0000
Subject: Re: Question about hibernation on sparc64
Message-Id: <20120412.152210.2217325787679111999.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <80041334231315@web149.yandex.ru>
In-Reply-To: <80041334231315@web149.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Buell <alex.buell@munted.eu>
Date: Thu, 12 Apr 2012 19:59:57 +0100

> On Thu, 2012-04-12 at 12:32 -0400, David Miller wrote:
>> From: Kirill Tkhai <tkhai@yandex.ru>
>> Date: Thu, 12 Apr 2012 15:48:35 +0400
>> 
>> > So I want to ask people who know sparc64 deeply. Are there any
>> > architecture limits which make hibernation on v9 impossible? May be
>> > anybody has researched this question.
>> 
>> I can't think of any sparc64 hardware which would support hibernation
>> in any reasonable way, so I'm quite surprised that you plan on
>> implementing support for it.  Perhaps you can elaborate your plans :-)
> 
> http://www.rugged-systems.com/p/mobilesunsolaris/0075.htm is a sparc64
> laptop :)

That's amusing but even that machine (and it's not a laptop, it's
a portable workstation) doesn't support hibernation.
