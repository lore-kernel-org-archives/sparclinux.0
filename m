From: Ben Collins <bcollins@debian.org>
Date: Fri, 28 May 2004 11:43:15 +0000
Subject: Re: hme hang in SMP (was: 2.6.6 SMP on UE2 hangs consistently)
Message-Id: <20040528114315.GA26289@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 28, 2004 at 11:07:04AM +0300, Meelis Roos wrote:
> > Did you try booting with maxcpus=1 or building without SMP ?
> 
> I did try maxcpus=1 now, this works too in addition to UP. So it's two
> CPU-s that's showing the bug, not just SMP kernel.
> 
> Additionally I found out that keyboard is actually OK, I just have to
> use the right keymap for 2.6 (duh). So only hme is dieing in real SMP.

Very odd. My Ultra2 has an HME, and I have it booted right now in SMP
(two CPU's) with the latest bk as of last night (2.6.7-rc1). Working
without problems. Same on my 6way e3000.

Both of these were running 2.6.6-rc2 for quite awhile without problems
aswell.

I have a feeling this has more to do with networking than HME
specifically. You have a lot of stuff enabled that I don't, like ipv6,
netfilter, QoS, IP_PNP, etc.

How about disabling all that just to see if it will boot. Then enable
one of those subsystems at a time to see what causes it.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
