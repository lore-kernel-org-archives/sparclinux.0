From: David Miller <davem@davemloft.net>
Date: Sun, 13 Sep 2009 06:00:30 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090912.230030.21528556.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 12 Sep 2009 13:05:59 +0200

> On Sat, Sep 12, 2009 at 02:59:43AM -0700, David Miller wrote:
>> From: Josip Rodin <joy@entuzijast.net>
>> Date: Sat, 12 Sep 2009 11:49:54 +0200
>> 
>> > I see this %pcr handling has been in debugging code (oprofile, performance
>> > counters) for some time before it moved into the NMI handler, so I'm
>> > guessing it didn't get enough testing because fewer people have the
>> > debugging features enabled. I would recommend disabling it for now in
>> > the stable releases until this grave regression is resolved.
>> 
>> Remind me what kernel you're trying now?
> 
> The 2.6.31 release. (Actually stable 2.6.31.y git but that's currently the
> same.)

Ok, I'm motivated to simply fix this and it seems you are too.

I'll come up with a game plane to kill this for good, because I
suspect whatever is causing this is actually unrelated to the
NMI feature and is actually something more funamental on SMP on
these UltraSPARC-III+ machines.
