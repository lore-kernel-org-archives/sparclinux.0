From: Bill Davidsen <davidsen@tmr.com>
Date: Wed, 24 Oct 2007 20:10:43 +0000
Subject: Re: [BUG] Raid1/5 over iSCSI trouble
Message-Id: <471FA6C3.6010404@tmr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BB92.7040701@systella.fr> <47161CE3.80909@systella.fr>	 <e9c3a7c20710170758p4046ca44labe370e94bca6e93@mail.gmail.com>	 <e9c3a7c20710170840u2ed8d6a9x26523eec6700ad11@mail.gmail.com>	 <47181CB2.1060602@tmr.com>  <471864F8.9010209@systella.fr>	 <1192809103.30976.11.camel@dwillia2-linux.ch.intel.com>	 <4718DE66.8000905@tmr.com> <471916B5.6080709@systella.fr>	 <47191855.4020402@systella.fr>  <47191BCF.2000908@systella.fr> <1192828331.30976.26.camel@dwillia2-linux.ch.intel.com> <4719B6DE.9040403@systella.fr> <471EF07A.5040007@systella.fr>
In-Reply-To: <471EF07A.5040007@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?QkVSVFJBTkQgSm/Dq2w=?= <joel.bertrand@systella.fr>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-raid@vger.kernel.org, sparclinux@vger.kernel.org, iscsitarget-devel@lists.sourceforge.net

BERTRAND Jo=C3=ABl wrote:
>     Hello,
>
>     Any news about this trouble ? Any idea ? I'm trying to fix it, but=20
> I don't see any specific interaction between raid5 and istd. Does=20
> anyone try to reproduce this bug on another arch than sparc64 ? I only=20
> use sparc32 and 64 servers and I cannot test on other archs. Of=20
> course, I have a laptop, but I cannot create a raid5 array on its=20
> internal HD to test this configuration ;-)

Sure you can, a few loopback devices and a few iSCSI, and you're in=20
business. I think the ongoing discussion of timeouts and whatnot may=20
bear some fruit eventually, perhaps not as fast as you would like. By=20
Saturday a solution may emerge.
>
>     Please note that I won't read my mails until next saturday morning=20
> (CEST).=20


--=20
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


