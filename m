From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 11 Jan 2005 14:36:05 +0000
Subject: Current BK kernel error
Message-Id: <20050111143605.GC4514@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

A pull of the current BK kernel failed to build, with an error in
mm/memory.c about pte_read() not being defined. This function was added
in at revsion 1.204, and the 'bk prs' with this comment:

D 1.204 05/01/04 18:48:23-08:00 gnb@melbourne.sgi.com[torvalds] 213 212 18/2/215
6
P mm/memory.c
C oprofile: add check_user_page_readable()

The pte_read() function is defined at include/asm-sparc64/pgtable.h for
64-bit Sparc, but is not defined for 32-bit Sparc. Anyone taken a shot
at making a patch for this yet?

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
