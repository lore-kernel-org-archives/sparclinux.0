From: Ben Collins <bcollins@debian.org>
Date: Tue, 03 Feb 2004 18:18:13 +0000
Subject: Re: Problems with bridging on Sparc64
Message-Id: <20040203181813.GK735@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <8AA870658244D4119AF600508BDF0A361D4BF107@usahm014.exmi01.exch.eds.com>
In-Reply-To: <8AA870658244D4119AF600508BDF0A361D4BF107@usahm014.exmi01.exch.eds.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I don't remember if you said what dist you were using, but here's a
64-bit debian package of the bridge-utils. If you have something other
than debian, you can use alien to convert the package to rpm, or do:

ar x bridge-utils64_0.9.6-5_sparc.deb data.tar.gz

And then gunzip/untar that.


http://www.phunnypharm.org/pub/for/sparc-folks/bridge-utils64_0.9.6-5_sparc.deb

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
