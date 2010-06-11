From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Jun 2010 03:08:37 +0000
Subject: Re: [PATCH 0/2] Replace of_device with platform_device
Message-Id: <AANLkTinVTGV32OfFaEp-zJpHtOWFHOvWPgxtxxocY2Du@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100604205930.2762.17131.stgit@angua>
	<AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
	<1276151543.1962.48.camel@pasglop>
	<AANLkTik2j5iDwcgIl_WyajaSRqLx5WK8Zf-25FBJ92Ch@mail.gmail.com>
	<1276218990.1962.81.camel@pasglop>
In-Reply-To: <1276218990.1962.81.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>

On Thu, Jun 10, 2010 at 7:16 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2010-06-10 at 10:46 -0600, Grant Likely wrote:
>>
>> It shouldn't need any fixing because I'm not touching the driver side
>> of the equation (unlike the last breakage where macio_driver had its
>> own copy of the match table which I missed). =A0In fact, there aren't
>> even any logic changes other than dealing with moving some of the
>> structure members in the sparc arch code. =A0If I did miss anything,
>> then it should show up in build testing.
>
> Ok, but I though you were actually replacing occurences of "of_device"
> with "platform_device", and so was wondering why you aren't changing the
> ones in macio. But yes, the #define you did might do the trick as long
> as the resources are still named the same etc...

I will, but it is a big job, so the #define lets me do it in chunks.
I made sure the member names in of_device were identical to
platform_device so that it works as a drop-in.

g.
