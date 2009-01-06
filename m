From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 06 Jan 2009 14:58:04 +0000
Subject: [PATCH 0/5] Eliminate most of sparc_ksyms_*.c
Message-Id: <4963717C.8080008@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

This patch set eliminates most of the definitions within 
arch/sparc/kernel/sparc_ksyms_*.c by moving them to their rightful places.

This is done within patches 1-3.

Note that this work was originally performed by Sam Ravnborg and these 
patches have been rebased and added to by myself.

I've tried to reflect this in the commit messages but may have gotten it 
a little wrong.

Patches 4 and 5 are cleanups that I had in my tree for an eventual 
oplib_*.h unification - but as this screws up my original patches and 
they're so small, I figured this'd be as good a time as any to send them.

Thanks,

Julian Calaby
