From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 22 May 2012 17:21:53 +0000
Subject: Re: Best userland for sparc32?
Message-Id: <CA+=Fv5QWb1rZc840JqecTML9L8V_LcvqbceWKQ5MGEtfG4uT_g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1205201859120.3202@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1205201859120.3202@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,


I've put together a gentoo based linux in the form of a live-cd/install-cd =
and a
"stage3" system tarball. Those of you that are familiar with gentoo
will know what to do. If not, just follow the gentoo sparc install
guide.

It has gcc-4.6.1 and binutils 2.21.1a I think.
I've tested it on sparcstation 4,5, 10 and 20. The sparcstation 10 and
20 I've tested with SMP. Hypersparc works as well but not with a more
recent kernel than 2.6.31.9. Single CPU microsparc and supersparc work
with recent kernels like 3.1.5 (not tested anything more recent).
Maybe recent work with on kernel for sparc32 has improved the odds of
locating some SMP bugs
which seems to cause stability probl0ems at least on sun4m with recent
kernels...

let me know if anyone want to give it a try, I can provide a CD install iso
and a system tarball via ftp.


Regards

Magnus

On Mon, May 21, 2012 at 1:11 AM, Julian Calaby <julian.calaby@gmail.com> wr=
ote:
> Hi,
>
> On Mon, May 21, 2012 at 3:01 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> On Sun, May 20, 2012 at 07:07:03PM +0300, Meelis Roos wrote:
>>> I have not tested any sparc32 configs since Debian dropped sparc32.
>>> However, I do have some hardware that I'd like to put to good use for
>>> testing the sparc32 changes (SS10 SP, SS10 MP, SS10 4x100 Ross, SS20
>>> (maybe SMP too), SS5 70 MHz stock CPU, SS5 with 170 MHz Fujitsu(?) CPU),
>>> SS4, probably some lunchboxes too if I find some big enough working
>>> HDD-s (LX, CLassic), ADEE S10Station (SS10 clone).
>>
>> Better test coverage on sparc32 is very welcome!
>> I am sure you will hit some interesting issues...
>
> Once I get stuff working, my SS10 (2x supersparcs), SS10 (2x 100MHz
> Hypersparc) and SSLX will be added to the mix.
>
>>> That leads to the question, what is the best userland to compile and run
>>> sparc32 kernels? This probably means recent gcc & binutils, and that
>>> they are routinely updated. I can ocassionally compile a binutils or a
>>> gcc if it has been automated by someone else (like in gentoo), or better
>>> use binary packages and update these. And I want to compile the kernels
>>> on these machines themselves (as all my tect machines do), to have
>>> better testing.
>>>
>>> So, what distros do people suggest?
>>
>> My personal setup is simple...
>> I used crosstool-ng to build my toolchainbased on gcc 4.5.2
>>
>> I tested several gcc versions back then and this was the version that wo=
rked for me.
>> My userland is very simple.
>> I have used buildroot to build a rootfs with a minimal set of tools.
>> Mostly busybox.
>>
>> Then I use tftpboot.img to do "boot net" so the image is fetched via tft=
p.
>> This allowed me to keep the solaris image on the disk.
>
> This is what I'm trying to get working with my setup, however at this
> point our paths diverge.
>
> I've managed to lay hands on the stage1, 2 and 3 images for the 2006.1
> release of Gentoo (the last sparc32 release) and my plan is to get the
> tftpboot image running, then use it to install Gentoo on the hard
> disks in one box (the hypersparc) and use NFSRoot for the others.
>
> I haven't done much with it recently, and the last time I fiddled with
> it I was getting Level 15 interrupts (memory issues) however
> OpenFirmware says it's fine, so I suspect a kernel bug.
>
> Thanks,
>
> --
> Julian Calaby
>
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/
> .Plan: http://sites.google.com/site/juliancalaby/
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
