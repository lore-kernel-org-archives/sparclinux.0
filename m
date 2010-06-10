From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 16:46:27 +0000
Subject: Re: [PATCH 0/2] Replace of_device with platform_device
Message-Id: <AANLkTik2j5iDwcgIl_WyajaSRqLx5WK8Zf-25FBJ92Ch@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100604205930.2762.17131.stgit@angua>
	<AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
	<1276151543.1962.48.camel@pasglop>
In-Reply-To: <1276151543.1962.48.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>

On Thu, Jun 10, 2010 at 12:32 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2010-06-04 at 15:13 -0600, Grant Likely wrote:
>> This series is based on Linus' current tree. =A0It eliminate struct
>> of_device in preparation for the merge of of_platform_bus_type and
>> platform_bus_type.
>>
>> Assuming there are no objections, I'll be putting these to linux-next
>> to stew sometime next week.
>
> I don't see any update to the macio stuff... have you fixed that
> separately or are you up to breaking it -again- ? :-)

It shouldn't need any fixing because I'm not touching the driver side
of the equation (unlike the last breakage where macio_driver had its
own copy of the match table which I missed).  In fact, there aren't
even any logic changes other than dealing with moving some of the
structure members in the sparc arch code.  If I did miss anything,
then it should show up in build testing.

I will try to dig out an mac machine and fire it up though.

>
> You should do build tests with a pmac32 or g5 defconfig every now and
> then.

I frequently build tested on many platforms:

http://kisskb.ellerman.id.au/kisskb/branch/13/

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
