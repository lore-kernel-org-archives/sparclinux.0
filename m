From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 16 Aug 2018 19:20:04 +0000
Subject: why is NCCS equal to 17 on sparc?
Message-Id: <20180816192004.GZ6515@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	AFAICS, on sparc we have termios->c_cc[] matching Solaris
one.  Same entries, same order - from INTR in ->c_cc[0] to LNEXT
in ->c_cc[15].  What the hell is (userland) ->c_cc[16] for?  The
kernel uses ->c_cc[16] for MIN, ->c_cc[17] - for TIME and noting,
AFAICS, uses ->c_cc[18].
	On the userland side, of course, MIN and TIME are
non-canon occupants of what would've been EOF and EOL slots
in canon mode...

	Looks like the kernel-side array (NCCS+2) should've been
18-element and userland one (NCCS) - 16-element...

	What am I missing here?
