From: Per =?utf-8?q?=C3=98yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Wed, 07 Jan 2004 06:24:19 +0000
Subject: Re: disk diagnostics
Message-Id: <200401070724.20426.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Torsdag 19 oktober 2006 10:50, skrev vincent@cojot.name:
> On Wed, 18 Oct 2006, Per Øyvind Karlsen wrote:
> > Oh well, I guess that I could just put it in a x86 box and run
> > diagnostics there if nothing else, less hazzle than installing solaris at
> > least..
>
> Is smartctl available on Linux/Sparc? I know it is available in most
> distros and also works on Solaris/Sparc.. If your disks are recent
> enough and smartctl is available on Linux/Sparc, you could ask them to
> perform the smartctl selftests and report their S.M.A.R.T status...? Most
> modern/post-36Gb disks have S.M.A.R.T, i think...
>
> I hope this helps..
Yes, I've been looking into smarttools, but as far as I get it, it won't take 
care of fixing things at such a low level as reallocating spare sectors to 
replace bad sectors on disk, it refers to the use of 'badblocks' etc. on a 
file system level..
-- 
Regards,
Per Øyvind Karlsen
Mandriva
