From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 20:25:40 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.132540.1618153823373898602.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 20:44:24 +0200

> On 09/19/2017 08:14 PM, David Miller wrote:
>>> Does it work without root privileges?
>> 
>> Depends upon what permissions and ownership the administrator decides
>> to set for /dev/mdesc
>> 
>> Which is identical to what you would get with sysfs, "file permissions"
>> 
>> This conversation is going nowhere, can you guys please drop this?
> 
> It's not going anywhere because you are not open to discussion. You
> are stuck in your opinion coming from your own personal usecase and
> refuse to accept that other users have different usecases.
> 
>> We're not exporting the machine desctription in a second way, period.
> 
> Not "we", you. You are refusing to make progress and that's frustrating,
> especially for all the folk from Oracle who are sending in patches all
> the time.

Look, there is even precedence for my decision.

We removed /proc/openprom exactly for the reasons I am giving for not
doing things that way.
