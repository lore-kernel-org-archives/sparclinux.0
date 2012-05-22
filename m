From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 22 May 2012 06:31:59 +0000
Subject: Re: Linux on sparc v7
Message-Id: <CAGRGNgUzHrbLr8qgp+bByF4=CeNctGG9P8+KhQVxya0JnShu7A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4FBA4DBC.9070609@gaisler.com>
In-Reply-To: <4FBA4DBC.9070609@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On Tue, May 22, 2012 at 4:28 PM, Daniel Hellstrom <daniel@gaisler.com> wrot=
e:
> On 05/21/2012 06:16 PM, Sam Ravnborg wrote:
>>
>> On Mon, May 21, 2012 at 04:14:20PM +0200, Daniel Hellstrom wrote:
>>>
>>> Hello Dave,
>>>
>>> I am trying to catch up on what has been happening lately with the sparc
>>> port. Have the latest patches removed support for SPARC V7 CPUs?
>>
>> Yes. The sun4c were the only users of v7 so today we tell gcc to generate
>> v8
>> code. This imply support for muldiv& =A0friends.
>>
>>
>> > From the sparc Makefile:
>>
>> =A0 =A0 KBUILD_CFLAGS =A0+=3D -mcpu=3Dv8
>
>
> Does this mean that if we change it to mcpu=3Dv7 or mcpu=3Dcypress (or re=
moving
> mcpu=3Dv8) the kernel can still be run on a V7 CPU? Or have software rout=
ines
> for making V8 mul/div operations on a V7 CPU been removed so that V7 CPUs
> can't run Linux regardless of compiler option?

As I understand it, all support for v7 CPUs, including the mul/div
routines has been annihilated.

So from 3.5 onwards, Linux required a v8 CPU or newer.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
