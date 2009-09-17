From: David Miller <davem@davemloft.net>
Date: Thu, 17 Sep 2009 00:07:34 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090916.170734.187290451.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 17 Sep 2009 01:29:37 +0200

> On Wed, Sep 16, 2009 at 03:48:18PM -0700, David Miller wrote:
>> From: Josip Rodin <joy@entuzijast.net>
>> Date: Wed, 16 Sep 2009 14:49:00 +0200
>> 
>> > I'm attaching the exact .config used in my last attempt, just in case.
>> 
>> Where is that attachment? :-) I want to try it again here myself as a
>> double check.
> 
> Oh sorry, standard attachment error :) Now it's attached.

BTW, while we're on the topic of configurations, dists should use a
CONFIG_NR_CPUS value of at least 256 as that's the highest cpu count
out there on real sparc64 systems (Bartoka 4 socket Niagara-T2+, 64
cpus per socket, 4 * 64 = 256).
