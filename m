From: Rob Landley <rob@landley.net>
Date: Mon, 11 Jan 2021 17:57:59 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <506e2355-0995-832a-1f9d-79b98a80ceff@landley.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org>
In-Reply-To: <20210110214653.GA1693373@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 1/10/21 3:46 PM, Sam Ravnborg wrote:
> Hi all,
>> Hi Arnd!
>>
>> (Please let's have this cross-posted for more visibility. I only learned about this
>>  while reading Phoronix news)
>>
>>> I also looked at non-ARM platforms while preparing for my article. Some of
>>> these look like they are no longer actively maintained or used, but I'm not
>>> doing anything about those unless the maintainers would like me to:
>>>
> 
>>> * sparc/sun4m: A patch for removing 32-bit Sun sparc support (not LEON)
>>>    is currently under review
>>
>> I don't think this has reached any agreement yet. Multiple people want it to stay.
> 
> None of the people that replied have any real use of the sun4m port,
> they only wanted it to stay because they had some machines or such.
> In other words - people will be sad if we sunset sun4m, but it will not
> hurt anyone as there are no users left.
> 
> I will include the above summary when I post v2 of the patch to sunset
> sun4m and sun4d. Then we will see what we conclude in the end.

I used to regression test it in my cross builds but I switched my
toolchains/userspace from uClibc to musl-libc a couple years back, and musl
never added sparc support.

Rob
