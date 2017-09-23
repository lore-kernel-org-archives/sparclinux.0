From: David Miller <davem@davemloft.net>
Date: Sat, 23 Sep 2017 01:35:34 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170922.183534.733727611262449161.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Fri, 22 Sep 2017 21:40:42 +0300

> On Wed, Sep 20, 2017 at 12:24 AM, Anatoly Pugachev <matorola@gmail.com> wrote:
>> On Tue, Sep 19, 2017 at 11:29 PM, David Miller <davem@davemloft.net> wrote:
>>> 'prtconf' has been in the sparc-utils package for probably like
>>> two decades.
>>
>> By the way, David, what is mdlint you mentioned earlier? I'm surprised
>> to hear about it for the first time in my sparc linux adventure.
>> Google seem doesn't know anything about it, and I failed to find it
>> with "mdlint linux sparc" / "linux sparc wiki mdlint"
>> Solaris does not have it (being I'm only 10 years with solaris
>> starting from version 9).
>> Why don't we have it in sparc-utils along with prtconf and eeprom?
> 
> David,
> 
> is it possible to download mdlint somewhere ?

It was part of the opensolaris sources, I ported it locally myself
so that it would build and work on Linux.

I do not know where you can download it, and I'm probably not allowed
to redistribute my modified version of the sources.

Sorry.
