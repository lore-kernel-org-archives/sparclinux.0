From: "Dan Williams" <dan.j.williams@intel.com>
Date: Sat, 27 Oct 2007 18:27:23 +0000
Subject: Re: [BUG] Raid1/5 over iSCSI trouble
Message-Id: <e9c3a7c20710271127p24635207p4b5cc03047118f36@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BB92.7040701@systella.fr> <4718DE66.8000905@tmr.com>
	 <471916B5.6080709@systella.fr> <47191855.4020402@systella.fr>
	 <47191BCF.2000908@systella.fr>
	 <1192828331.30976.26.camel@dwillia2-linux.ch.intel.com>
	 <4719B6DE.9040403@systella.fr> <471EF07A.5040007@systella.fr>
	 <e9c3a7c20710241649qb26c36by5733a93cff394c40@mail.gmail.com>
	 <47233D37.6070409@systella.fr>
In-Reply-To: <47233D37.6070409@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-raid@vger.kernel.org, sparclinux@vger.kernel.org, iscsitarget-devel@lists.sourceforge.net, Ming Zhang <blackmagic02881@gmail.com>

On 10/27/07, BERTRAND Jo=EBl <joel.bertrand@systella.fr> wrote:
> Dan Williams wrote:
> > Can you collect some oprofile data, as Ming suggested, so we can maybe
> > see what md_d0_raid5 and istd1 are fighting about?  Hopefully it is as
> > painless to run on sparc as it is on IA:
> >
> > opcontrol --start --vmlinux=3D/path/to/vmlinux
> > <wait>
> > opcontrol --stop
> > opreport --image-path=3D/lib/modules/`uname -r` -l
>
>         Done.
>

[..]

>
>         Is it enough ?

I would expect md_d0_raid5 and istd1 to show up pretty high in the
list if they are constantly pegged at a 100% CPU utilization like you
showed in the failure case.  Maybe this was captured after the target
has disconnected?
