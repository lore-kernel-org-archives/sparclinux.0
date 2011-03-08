From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 08 Mar 2011 21:20:56 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <AANLkTim912GWEc1UYTjDe=kGXmmsnmopQaz__ACtv3aa@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Sam,

> Regarding the segfault - the easiest way forward would be to split the
> patch up in smaller chunks so we know which part causes the segfault to h=
appen.

Yes, I'll see if I can work that out.

> I assume you had to hand-apply the revert.
That's what I did.

> If you could post the exact patch you used for revert
> I will try to split it up in smaller logical parts.
I'll post that patch later.

> I have a sparcstation 5 that I managed to boot -
> unfortunately itdid not show erratic behaviour as you describe.

My sparcSTATION 5 boots sparc-next-2.6 with your genirq patch just fine too.
It's up for almost 2 days now, doing things.  It has 4 EXT3
filesystems. No problemo.

Marcel


On Tue, Mar 8, 2011 at 10:09 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Mar 08, 2011 at 09:22:07PM +0100, Marcel van Nies wrote:
>> Hi,
>>
>> The good news:
>> sparc-next-2.6 with commit 4d14a459857bd151ecbd14bcd37b4628da00792b reve=
rted
>> does NOT segfault. I did not apply the genirq patch yet.
>
> Narrowing it down to a sinlge patch is good.
>
>>
>> The bad news:
>> Segfault gone, say hello to EXT2 read failure =A0 :o(
>
> So we are dealing with two faults. Not a suprise considering how
> little we have tested on sparc32 lately.
>
>> I'll rebuild this kernel with the esp_debug.patch Sam sent a couple of d=
ays ago.
>
> I have tried said patch myself.
> You may try to play around with the value as it produces a lot of output.
>
> Regarding the segfault - the easiest way forward would be to split the
> patch up in smaller chunks so we know which part causes the segfault to h=
appen.
>
> I assume you had to hand-apply the revert. If you could post the exact pa=
tch
> you used for revert I will try to split it up in smaller logical parts.
> But likely not until the weekend.
>
> I have a sparcstation 5 that I managed to boot - unfortunately it
> did not show erratic behaviour as you describe.
> And for now I do not have any Ext2 filesystem on disk to play with.
>
> =A0 =A0 =A0 =A0Sam
>
