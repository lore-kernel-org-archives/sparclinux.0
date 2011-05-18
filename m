From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 May 2011 15:47:10 +0000
Subject: Re: [PATCH] of: fix race when matching drivers
Message-Id: <BANLkTik0d8+E94-KjH9wFGDyGjUM7hVkug@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTikhKqcpdadpM3RQdYvDrPn46_v6_Q@mail.gmail.com>
 <20110517.134312.226762699.davem@davemloft.net> <alpine.SOC.1.00.1105021259220.6200@math.ut.ee>
 <1305732459_6563@mail4.comsite.net> <BANLkTimV0Xm7-C2yRh7bcyaQzdgET+0vmg@mail.gmail.com>
In-Reply-To: <BANLkTimV0Xm7-C2yRh7bcyaQzdgET+0vmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Milton Miller <miltonm@bga.com>
Cc: David Miller <davem@davemloft.net>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

[cc'ing Linus: This is fix for a 2.6.39 regression, so just a heads up
that I'll be sending you a pull req ASAP (later this morning)]

On Wed, May 18, 2011 at 9:41 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Wed, May 18, 2011 at 9:27 AM, Milton Miller <miltonm@bga.com> wrote:
>> If two drivers are probing devices at the same time, both will write
>> their match table result to the dev->of_match cache at the same time.
>>
>> Only write the result if the device matches.
>>
>> In a thread titled "SBus devices sometimes detected, sometimes not",
>> Meelis reported his SBus hme was not detected about 50% of the time.
>> From the debug suggested by Grant it was obvious another driver matched
>> some devices between the call to match the hme and the hme discovery
>> failling.
>>
>> Reported-by: Meelis Roos <mroos@linux.ee>
>> Signed-off-by: Milton Miller <miltonm@bga.com>
>> ---
>>
>> Grant, I really think this of_match cache in the device node is bad a
>> bad tradeoff, and am willing to submit patches to remove it for 2.6.40.
>> It is only used by about 26 drivers and all use it once during probe
>> to fill out their driver data. =A0It comes at the cost of a long for
>> every struct device in every system.
>
> Ah, bugger. =A0I had /thought/ that matching and probing were kept
> together with a mutex. =A0So, yes, this is bad and the of_match needs to
> be removed. =A0Thanks for volunteering to submit the patch. =A0It should
> be backported to 2.6.39 too.
>
>> I'll even offer to throw in a patch to cache the parsing of the
>> compatible property to speed up of_device_is_compatible if needed.
>
> That would be useful. =A0:-)
>
> I'll pick up your patch right now and fire it off to Linus.

... it's not perfect since it will break some theoretical drivers
unbind/rebind use-cases, but I cannot think of any actual examples,
and it is far safer than the current code.  Regardless, the removal of
of_match will definitely need to go into stable when it is ready.

g.
