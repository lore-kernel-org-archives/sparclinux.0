From: Ben Collins <bcollins@debian.org>
Date: Mon, 05 Apr 2004 17:32:25 +0000
Subject: Re: Question on OOPS / U60 / Kernel 2.4.24-SMP
Message-Id: <20040405173225.GK13168@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CFE6A2529AC5FA439B3D852B0F2A68371A2A96@OEKAW2EXVS02.hbi.ad.harman.com>
In-Reply-To: <CFE6A2529AC5FA439B3D852B0F2A68371A2A96@OEKAW2EXVS02.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I think I should give some option regarding the system architecture to the
> ksymoops call. I did not find out which ones; ksymoops -a '?' tells me

-t elf64-sparc -a sparc:v9

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
