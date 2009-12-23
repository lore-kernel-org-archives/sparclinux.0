From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Wed, 23 Dec 2009 01:14:11 +0000
Subject: Re: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <a4423d670912221714o520010faoe45e5e5c87fb7a3c@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

2009/12/21 Sam Ravnborg <sam@ravnborg.org>:
> On Mon, Dec 21, 2009 at 12:14:11PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Mon, 21 Dec 2009 20:59:21 +0100
>>
>> > As the comment says:
>> > "Don't use BUG() or BUG_ON() unless there's really no way out;"
>> >
>> > I would have expected to see something like this:
>> > #define BUG() do {} while(1)
>>
>> Maybe we can use "unreachable()" here.
> Makes sense.
>
> Alexander - could you please try to add an
> unreachable() call in in bug.h and if it
> kills the warnings as expected then send
> a patch to Arnd including a proper
> changelog describing why this was need.
It fixes the problem, thanks!
