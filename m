From: Ben Collins <bcollins@debian.org>
Date: Tue, 04 May 2004 16:01:58 +0000
Subject: Re: Illegal instruction with silo 1.4.4 and ultra 1
Message-Id: <20040504160158.GI3647@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0404292048550.13989@stargazer.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> %PC  40004498 %nPC 4000449c
> %TBA f0000000 %CCR 44 XCC:nZvc   ICC:nZvc

Check your System.map and see where 0x404498 falls.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
