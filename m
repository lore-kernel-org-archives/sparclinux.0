From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 30 Apr 2004 01:52:34 +0000
Subject: Found the cause of my 2.6.6-rc boot failures
Message-Id: <20040430015234.GH27793@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

The 1.69->1.70 changes in fs/dcache.c are the problem keeping my system
from booting. This change introduced the bit of code where the global
'mempages' variable is reduced by calling nr_free_pages() and
subtracting that result. By commenting out the change to on line 1634
the machine continues the boot sequence. Unfortunately I encounter a
kernel trap after mounting the first drive in the machine, so I can't
yet claim victory in getting a 2.6.6-rc kernel to work on the machine.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
