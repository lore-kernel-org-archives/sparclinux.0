From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 07 Oct 2009 05:18:04 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <646765f40910062218s19d540f9q14c9086bedd1d9da@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
In-Reply-To: <fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Sam Creasey <sammy@sammy.net>, Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Wed, Oct 7, 2009 at 14:49, Grant Likely <grant.likely@secretlab.ca> wrot=
e:
> On Tue, Oct 6, 2009 at 10:29 PM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>>
>> So here goes. =A0I've begun the work to merge and clean up the OF device
>> tree handling code and this is my first set of patches. =A0Not fully
>> tested yet, but I'm getting them out to the lists so that I can start
>> responding to comments and collecting acks. =A0This first batch isn't
>> anything exciting, just a merge of common code

Good work, for what it's worth, this all looks good to me.

> However, I've completely devoted to this work for at least the next
> two months, so there are plenty more patches to follow. =A0Once I've
> got all the common code merged between Microblaze, PowerPC and Sparc
> I'll be fix the endian problems and making it easily usable by other
> architectures like ARM and MIPS. =A0Lots of work to be done.

On the subject of merging code, I know that the SUN3 code in m68k uses
a similar prom interface to the sparc32 code. (and I've also
considered unifying that and ... well ... see above) Does anyone know
if it has an OpenFirmware interface for it's devices? Is OF on SUN3
even remotely useful? Does Linux on SUN3 even work with modern
kernels?

Another issue is that there is at least one driver in the kernel that
depends on both PPC and OF to work around the differences in the
implementations of OpenFirmware on Sparc and PowerPC. (I submitted a
patch for it, but can't remember the driver's name) Whilst the
driver's author assures me that the hardware will never go anywhere
near Sparc, it can't hurt to drop the dependency on PPC for additional
compile testing coverage - and because it's the Right Thing. (and the
reduction of cheap hacks like this can't be bad either.)

Other than that, good work, and keep going.

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
