From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 16 Oct 2009 03:18:21 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <fa686aa40910152018i2dbf1876s4de3771e42f9c3d@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091015120007.3780c59b.sfr@canb.auug.org.au>
	<fa686aa40910151006k43b07c30q1e43c3b1ae4af561@mail.gmail.com>
	<20091016103829.323c89d7.sfr@canb.auug.org.au>
In-Reply-To: <20091016103829.323c89d7.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Thu, Oct 15, 2009 at 5:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Grant,
>
> On Thu, 15 Oct 2009 11:06:15 -0600 Grant Likely <grant.likely@secretlab.c=
a> wrote:
>>
>> In the mean time, I've pushed out the current series with acked-bys
>> added to my git server. =A0I think I'm ready for things to start going
>> into linux-next. =A0Since this is the first time I've asked for a tree
>> to be added to linux-next, please let me know if you see anything
>> troublesome or problematic. =A0Here's the tree:
>>
>> The following changes since commit 4bdf0bb7d64cf672199519b3d808e2a82f5b5=
9e9:
>> =A0 Grant Likely (1):
>> =A0 =A0 =A0 =A0 powerpc/5200: Update defconfigs
>
> Um, that commit is in no tree but yours ...

It should be in Ben's merge tree shortly, and Linus' shortly after
that, but yeah that was lazy.  It was the tree that I tested my
commits on, and I should have either rebased or waited until it
actually hit mainline.  I just wanted to get the ball rolling before
heading out the door for Japan.

>> are available in the git repository at:
>>
>> =A0 git://git.secretlab.ca/git/linux-2.6 next-devicetree
>
> I have added this for today, but note that it contains stuff that is not
> devicetree related. =A0Trees in linux-next should be based on other trees
> in linux-next (almost always Linus' tree, but any other nonrebasing tree
> is fine).

Thanks.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
