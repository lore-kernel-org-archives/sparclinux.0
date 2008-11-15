From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:29:20 +0000
Subject: [RFC] Unify sparc and sparc64 Kconfig
Message-Id: <20081115212920.GA8712@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave et al.

The following set of patches merges the Kconfig files
of sparc and sparc64.

The patchset consist of a few preparational pacthes that
makes sparc look more like sparc64 to keep the size of
the final merge in a reviewable size.

I have tested the final result comparing the menuentries
and checked that I had the same menu entires before and after
for both sparc and sparc64.
As the menu have become more structured as a result of
the merge this required some browsing to find them all
before and after.

Comments appreciated.

Patches follows - below is the overview:

Sam Ravnborg (8):
      sparc: unify Kconfig.debug
      sparc: refactor Kconfig a little
      sparc64: added more config options to the menus
      sparc: drop UNIX98_PTYS from arch Kconfig
      sparc: use Kconfig.hz
      sparc: add menu "Executable file formats"
      sparc: add "Bus options" to Kconfig
      sparc,sparc64: unify Kconfig

 arch/sparc/Kconfig         |  493 ++++++++++++++++++++++++++++++++------------
 arch/sparc/Kconfig.debug   |   26 +++
 arch/sparc64/Kconfig       |  434 +--------------------------------------
 arch/sparc64/Kconfig.debug |   44 ----
 4 files changed, 390 insertions(+), 607 deletions(-)

	Sam
