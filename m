From: David Miller <davem@davemloft.net>
Date: Thu, 30 Apr 2009 10:01:30 +0000
Subject: Another set of debian niagara bugs
Message-Id: <20090430.030130.124967500.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


LDOM guests can't install correctly because sunvdc and sunvnet don't
automatically load.

You can get through the installation by picking them in the various
module list menus.

But once you reboot into the system, the initram can't load the sunvdc
module and therefore root won't mount.

Ubuntu had this and the niagara console detection working two years
ago :-(
