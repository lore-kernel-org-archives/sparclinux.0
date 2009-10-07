From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 14:02:43 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <fa686aa40910070702j470785d2ka2621122a8e2f1fd@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
	<200910070209.59311.rob@landley.net>
In-Reply-To: <200910070209.59311.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Landley <rob@landley.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Wed, Oct 7, 2009 at 1:09 AM, Rob Landley <rob@landley.net> wrote:
> On Tuesday 06 October 2009 23:49:04 Grant Likely wrote:
>>
>> However, I've completely devoted to this work for at least the next
>> two months, so there are plenty more patches to follow. =A0Once I've
>> got all the common code merged between Microblaze, PowerPC and Sparc
>> I'll be fix the endian problems and making it easily usable by other
>> architectures like ARM and MIPS. =A0Lots of work to be done.
>
> Is there any news on getting QEMU to parse a device tree to figure out wh=
at
> hardware to emulate? =A0(I.E. using the device tree code to let qemu prov=
ide
> configurable board emulations instead of hardwiring them in C code?)

Not that I have, but I expect that I will be hacking on QEMU as part
of this work.

> Also, what would be involved in getting x86 to (at least have the option =
to)
> use the device tree stuff?

It would be very easy once the endian issues are worked out since the
device tree is just a data format to be parsed.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
