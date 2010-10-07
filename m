From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 07 Oct 2010 23:01:28 +0000
Subject: Re: phandle patch review?
Message-Id: <AANLkTikaAkPqgKu-+JTbPOjiqKZdOcz+czEGUvvbc00y@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Oct 5, 2010 at 1:29 PM, Andres Salomon <dilinger@queued.net> wrote:
> On Tue, 28 Sep 2010 14:59:53 -0700
> Andres Salomon <dilinger@queued.net> wrote:
>
>> On Wed, 29 Sep 2010 05:39:59 +0900
>> Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>> > On Wed, Sep 29, 2010 at 4:48 AM, Andres Salomon
>> > <dilinger@queued.net> wrote:
>> > > Hi Grant,
>> > >
>> > > I'm assuming the sparc patches can go through your tree as well.
>> > > Please let me know if anything else needs to happen, now that we
>> > > have an ACK from davem.
>> >
>> > Did the phandle -> types.h issues get sorted out? =A0I can't remember.
>>
>> The relevant thread was here:
>> https://patchwork.kernel.org/patch/140991/
>>
>> I found Sam's initial comment unclear, so I asked for clarification
>> (specifying that we didn't need phandle to be exported to userspace);
>> his response was:
>>
>> "So the above looks good considerign that userspace
>> so far does not require ihanlde/phandle."
>>
>> I left it open-ended regarding whether or not userspace might want
>> phandle/ihandle to be exported (that's more a question for you
>> flat devicetree folks :) , but for my purposes not having it exposed
>> to userspace is just fine.
>
>
>
> So yeah, please let me know if there's anything outstanding that I
> missed that would keep the patches from getting merged.

Okay, I'm confused.  As you say, asm/openprom.h is exported.  None of
openprom.h is protect with __KERNEL__, so all of it gets exposed to
userspace.  You're patch adds phandle to the __KERNEL__ protected
section of types.h, which means that it is unavailable to userspace.
In which case anything from userspace including asm/openprom.h will
fail to compile, or am I missing something?

g.
