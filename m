From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 22:12:38 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20170919.151238.1806280768295761383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 15:08:28 -0700 (PDT)

> From: Kjetil Oftedal <oftedal@gmail.com>
> Date: Wed, 20 Sep 2017 00:03:30 +0200
> 
>> On 19/09/2017, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
>>> On 09/19/2017 10:24 PM, David Miller wrote:
>>>> davem@patience:~/src/GIT/sparc-next$ dpkg -S /usr/sbin/prtconf
>>>> sparc-utils: /usr/sbin/prtconf
>>>>
>>>> Come again?
>>>
>>> David, seriously, are you arguing about Debian packages with me?
>>>
>>> sparc-utils is part of the *unreleased* distribution because *I*
>>> put it there. *unreleased* is *not* an official part of Debian.
>>>
>>> sparc-utils is *not* part of Debian unstable.
>>>
>>> Adrian
>>>
>> 
>> Actually, sparc-utils was a part of wheezy/stable before Debian decided
>> to drop the official SPARC port.
> 
> What a relief, some sanity, _THANK_ _YOU_.

And btw this really sounds like a _disincentive_ to use the current sparc64
debian port, if useful utilities are being removed from the primary sparc64
set of packages like this.

I keep hearing about how I am getting in the way of users making use of
the sparc64 port.

But honestly I haven't done things like remove core utilities or anything
like that.

The worst thing I might have done is given it a lot of bad press because
I still to this day thing that using a default of 64-bits for all userland
utilities is a huge mistake.  And that for performance reasons 32-bit
should be the default, and things like databases and what--have-you should
be built 64-bit on a case by case basis.

This is why I won't upgrade and I'll keep kicking the tires on my ancient
debian sparc installs.

Maybe other people see things the similarly to how I do, and share
some of my opinions, and that's at least part of the real reason
sparc64/debian doesn't have a lot of uptake.
