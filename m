From: Ben Collins <bcollins@debian.org>
Date: Mon, 02 Feb 2004 03:26:57 +0000
Subject: Re: Oops with 2.6.2-rc3
Message-Id: <20040202032657.GD651@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1075667365.2732.4.camel@bonnie79>
In-Reply-To: <1075667365.2732.4.camel@bonnie79>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Using defaults from ksymoops -t elf32-sparc -a sparc

You need to pass the right arguments to ksymoops. It defaults to
sparc32. Use "-t elf64-sparc -a sparc:v9"

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
