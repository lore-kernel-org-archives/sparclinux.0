From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Thu, 08 Jan 2009 21:23:41 +0000
Subject: Re: [PATCH v2 0/5] Eliminate most of sparc_ksyms_*.c
Message-Id: <646765f40901081323h40c67437mdd777e0632b090f4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4965F1C6.1090700@gmail.com>
In-Reply-To: <4965F1C6.1090700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 9, 2009 at 07:03, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Thu, Jan 08, 2009 at 11:29:58PM +1100, Julian Calaby wrote:
>> Hi all,
>>
>> This patch set eliminates most of the definitions within
>> arch/sparc/kernel/sparc_ksyms_*.c by moving them to their rightful places.
>>
>> This is done within patches 1-3.
>>
>> Note that this work was originally performed by Sam Ravnborg and these
>> patches have been rebased and added to by myself.
>>
>> I've tried to reflect this in the commit messages but may have gotten it
>> a little wrong.
>>
>> Patches 4 and 5 are cleanups that I had in my tree for an eventual
>> oplib_*.h unification - but as this screws up my original patches and
>> they're so small, I figured this'd be as good a time as any to send them.
>>
>> Changes in version 2:
>> 1. Patches 2 and 3 have a few more includes added to the modified files.
>> 2. It shouldn't be word wrapped this time!
>
> Hi Julian.
>
> I have tested your patches by applying them one-by-one
> and done both sparc and sparc64 builds.
>
> Everything worked as expected - good work!

Thanks for testing and reviewing them.

Hopefully we can fix the declarations at some point.

My stance on this is: as this functionality that is defined in
assembler, having nasty C code is acceptable - providing that it's
documented. (which we could improve somewhat)

I plan to merge sparc_ksyms_*.c into (possibly) another ksyms.c,
however I have a compile error in a module to fix first.

Thanks for all your help on this and for looking over my patches.

-- 
Julian Calaby

Email: julian.calaby@gmail.com
