From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 08 Mar 2011 01:10:03 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq support]
Message-Id: <AANLkTim6t-utdNScrVmfo9UZrz9dHJHtEw6pmJY6skiw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

git bisect came up with this:

4d14a459857bd151ecbd14bcd37b4628da00792b is the first bad commit
commit 4d14a459857bd151ecbd14bcd37b4628da00792b
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Dec 10 23:32:10 2009 -0800

    sparc: Stop trying to be so fancy and use __builtin_{memcpy,memset}()

    This mirrors commit ff60fab71bb3b4fdbf8caf57ff3739ffd0887396
    (x86: Use __builtin_memset and __builtin_memcpy for memset/memcpy)

    Signed-off-by: David S. Miller <davem@davemloft.net>

Marcel



On Mon, Mar 7, 2011 at 8:07 AM, Marcel van Nies <morcles@gmail.com> wrote:
> Hi,
>
>> You shouldn't have to go back that far... =A0I was last running 2.6.22 on
>> hyperSPARC successfully. =A0Ok, maybe that's not so helpful as it looks
>> like it's been a while since I've built a sparc kernel. =A0Probably time
>> for me to also try out a new kernel.
>
> 2.6.32 is fine too:
> Linux ross 2.6.32.27-up #2 Sun Mar 6 23:05:25 CET 2011 sparc sun4m
> ROSS HyperSparc RT625 or RT626 GNU/Linux
>
> Today, I'll try to find out which commit causes the problems.
>
> Marcel
>
>
> On Sun, Mar 6, 2011 at 10:11 PM, Bob Breuer <breuerr@mc.net> wrote:
>> Josip Rodin wrote:
>>> On Sun, Mar 06, 2011 at 10:13:56AM +0100, Marcel van Nies wrote:
>>>> The hyperSPARC gives the same error without the final genirq patch.
>>>>
>>>> On Sun, Mar 6, 2011 at 8:23 AM, Marcel van Nies <morcles@gmail.com> wr=
ote:
>>>>> The hyperSPARC boots, but fails when starting init. It runs fine on 2=
.6.17.
>>>
>>> I realize that it may be a difficult proposition, but you could try to
>>> git bisect it.
>>>
>>> Did you try it on anything after 2.6.17, maybe that narrows it down fur=
ther?
>>>
>>
>> You shouldn't have to go back that far... =A0I was last running 2.6.22 on
>> hyperSPARC successfully. =A0Ok, maybe that's not so helpful as it looks
>> like it's been a while since I've built a sparc kernel. =A0Probably time
>> for me to also try out a new kernel.
>>
>> Bob
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
