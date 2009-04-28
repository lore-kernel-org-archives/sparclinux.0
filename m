From: David Miller <davem@davemloft.net>
Date: Tue, 28 Apr 2009 08:44:57 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090428.014457.59141349.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 28 Apr 2009 09:09:34 +0100

> On Tue, Apr 28, 2009 at 12:57:12AM -0700, David Miller wrote:
>> From: Jurij Smakov <jurij@wooyd.org>
>> Date: Tue, 28 Apr 2009 08:54:07 +0100
>> 
>> > The bug I've mentioned, and which should be resolved in this image, is 
>> > http://bugs.debian.org/504721. I see, however, that we never got a
>> > confirmation from the original reporter that the fix worked on his machine
>> > (it did work for mine).
>> 
>> So what is your system exactly?  Is it a niagara box?
> 
> It's a SunBlade 1000, but the symptoms described in this bug (reporter's box
> was Niagara) were the same on it, so I assumed that fixing it for my box fix
> it for Niagara as well (which is not necessarily true).

It won't, most likely because the device name is totally different
for Niagara's console device vs. the serial console device used
on all other types of boxes.
