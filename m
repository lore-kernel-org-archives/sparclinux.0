From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 31 Jan 2004 02:59:09 +0000
Subject: 2.6.x SMP RED_state in prom_startcpu()
Message-Id: <20040131025909.GD624@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Well, the bootlogs are rather uninteresting, but I've got a 2x u2 that
seems to drop into RED_state after calling prom_startcpu() on 2.6 (I
narrowed it down with prom_printf()'s). UP seems comes up fine. I sort
of flopped in an attempt to write a RED_state trap handler to get a
backtrace or determine the cause, so I'm punting for the moment.


-- wli
