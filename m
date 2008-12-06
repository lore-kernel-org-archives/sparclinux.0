From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 21:32:27 +0000
Subject: unify idprom.c
Message-Id: <20081206213227.GA28686@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Following two patches unifies idprom.c
sparc64 did not have the prom_halt() in the warning situations
so I removed these so they no longer appear in the sparc32 variant.

I fixed a few codestyle issues when I was there and
checked that saprse is happy (ne warnings).

For good measure I also ran checkpatch.pl on the file
and it did not complain about something that was relevant to fix.

Build tested only as usual.

	Sam

