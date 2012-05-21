From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 May 2012 16:22:53 +0000
Subject: How to recognize a LEON CPU?
Message-Id: <20120521162253.GB5733@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Who is the relevant Gaisler contact person these days for Linux stuff?
I sometimes uses Daniel, sometimes Konrad.

I can just add both of you - this is no problem.
As I plan to update the LEON integration it would be good
to have in place.

Anyway - the real question..

In head_32.S I need very early on to determine the CPU type,
so I can distingush between LEON and SUN.
This is due to LEON using a different ASI for mmuregs
as discussed in another mail.

I assume this can be determinded from PSR.
If this is correct - then what values shall I use
to determine if the relevant cpu is LEON or SUN?

	Sam
