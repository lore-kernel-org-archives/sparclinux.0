From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Feb 2008 20:39:10 +0000
Subject: sparc64 section mismatch status
Message-Id: <20080222203910.GG7154@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David et al.

After applying the patches I just sent to you
and a third for hpt366 (sent to Bart) my sparc64
build is section mismatch clean.

I have not tried different configs neither
allyesconfig etc.

Most of the remaining patches are queued by akpm
and I hope they hit mainlin before next merge window
but thats up to Andrew to judge.
That will bring down the nosie level significantly.

If you see any section mismatch warnings in the
configs you use then please do a

make CONFIG_DEBUG_SECTION_MISMATCH=y

build and send me the config + the warning output
and I will see if I can fix it.

Or even better - fix it up yourself...

	Sam
